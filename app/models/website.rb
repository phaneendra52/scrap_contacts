class Website < ActiveRecord::Base

  has_many :web_pages

  accepts_nested_attributes_for :web_pages, :allow_destroy => true

  attr_accessor :next_page_link_path, :pagination_links_parent_path, :pagination_links_path, :products_parent_path, :products_link_path, :file_name, :sheet_name, :product_links, :agent, :page, :web_page

  def parse_products
    web_pages.each do |web_page|
      @web_page = web_page
      set_params
      parse_webpage
    end
  end

  def parse_webpage
    get_all_product_links
    sheet, book = return_worksheet_and_workbook
    @product_links.each_with_index do |product_link, product_index|
      agent = Mechanize.new
      link = "http://www.episcopalacademy.org/fs/elements/1741?is_draft=false&show_profile=true&const_id=#{product_link}"
      page = agent.get(link)
      sleep(1)
      page_contents_data = @web_page.page_contents
      page_contents_length = page_contents_data.length
      page_contents_data.each_with_index do |page_content, column_index|
        if product_index == 0
          cell = sheet.add_cell(0, column_index, page_content.content_field)
        end
        if page_content.content_field == 'School Email'
          email_params = page.at(page_content.content_path)
          if email_params.present?
            email_params = email_params.text.strip.split('insertEmail(')[1..-1].join(',').split(');')[0..-2][0].gsub(/"/, '').split(',')
          end
          content = Website.generate_email(email_params)
        else
          content = page.at(page_content.content_path)
          content = content.text if content.present?
        end
        if content.present?
          cell = sheet.add_cell(product_index+1, column_index, content.strip)
        end
      end
    end
    book.write @file_name
  end

  private

    def set_params
      webpage_url = @web_page.url
      @next_page_link_path = @web_page.next_page_link_path
      @pagination_links_parent_path = @web_page.pagination_links_parent_path
      @pagination_links_path = @web_page.pagination_links_path
      @products_parent_path = @web_page.products_parent_path
      @products_link_path = @web_page.products_link_path
      @file_name = @web_page.file_name
      @sheet_name = @web_page.sheet_name
      @product_links = []
      @agent = Mechanize.new
      @page = @agent.get(webpage_url)
    end

    def self.generate_email(email_params)
      email = ''
      if email_params.present?
        t = email_params[0].strip
        n = email_params[1].strip
        r = email_params[2].strip
        i = email_params[3].strip
        email = r.split("").reverse().join("")+"@"+n.split("").reverse().join("")
      end
      email
    end

    def return_workbook
      if File.exist?(@file_name)
        book = RubyXL::Parser.parse(@file_name)
      else
        book = RubyXL::Workbook.new
      end
      return book
    end

    def return_worksheet_and_workbook
      book = return_workbook
      sheet = book[@sheet_name]
      if sheet.blank?
        @sheet_name = @sheet_name.gsub("/", "-")
        sheet = book[@sheet_name]
        if sheet.blank?
          sheet = book["Sheet1"]
          if sheet.present?
            sheet.sheet_name = @sheet_name
          else
            sheet = book.add_worksheet(sheet_name)
          end
        end
      end
      sheet.delete_column
      return [sheet, book]
    end

    def get_product_view_links
      @page.search(products_parent_path).each do |product| 
        constituent_id = product.at(products_link_path).attr('data-constituent-id').strip
        @product_links << constituent_id
      end
    end

    def get_all_product_links
      if @page.present?
        next_page = @page.at(@next_page_link_path)
        pagination_links = @pagination_links_parent_path.present? ? @page.search(@pagination_links_parent_path) : nil
        get_product_view_links
        if next_page.present?
          while next_page.present? do
            next_page_link = next_page.attr('href')
            @page = @agent.get(next_page_link)
            sleep(1)
            next_page = @page.at(@next_page_link_path)
            get_product_view_links
          end
        elsif pagination_links.present?
          pagination_links = pagination_links[1..-1]
          pagination_links.each do |pagination_link|
            pagination_link = pagination_link.attr('href')
            @page = @agent.get(pagination_link)
            sleep(1)
            get_product_view_links
          end
        end
      else
        puts "page doesn't exist"
      end
    end

end