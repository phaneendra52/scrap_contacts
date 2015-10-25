# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Website

website = Website.new
website.name = "Amazon"
website.save

# # Web page 1

# web_page = WebPage.new
# web_page.website_id = website.id
# web_page.url = 'http://www.amazon.com/gp/bestsellers/grocery/ref=pd_dp_ts_gro_1'
# web_page.next_page_link_path = '#pagnNextLink'
# web_page.pagination_links_parent_path = '.zg_pagination .zg_page'
# web_page.pagination_links_path = 'a[1]'
# web_page.products_parent_path = '#zg_centerListWrapper .zg_itemImmersion'
# web_page.products_link_path = '.zg_title a[1]'
# web_page.file_name = 'test_products.xlsx'
# web_page.sheet_name = 'test100_products'
# web_page.save

# # Page content 1

# page_content = PageContent.new
# page_content.content_field = 'Product Title'
# page_content.content_path = '#productTitle'
# page_content.web_page_id = web_page.id
# page_content.save

# page_content = PageContent.new
# page_content.content_field = 'Brand'
# page_content.content_path = '#brand'
# page_content.web_page_id = web_page.id
# page_content.save

# page_content = PageContent.new
# page_content.content_field = 'Price'
# page_content.content_path = '#priceblock_ourprice'
# page_content.web_page_id = web_page.id
# page_content.save



# web_page = WebPage.new
# web_page.website_id = website.id
# web_page.url = 'http://www.amazon.com/gp/bestsellers/grocery/ref=pd_dp_ts_gro_1'
# web_page.next_page_link_path = '#pagnNextLink'
# web_page.pagination_links_parent_path = '.zg_pagination .zg_page'
# web_page.pagination_links_path = 'a[1]'
# web_page.products_parent_path = '#zg_centerListWrapper .zg_itemImmersion'
# web_page.products_link_path = '.zg_title a[1]'
# web_page.file_name = 'test_products.xlsx'
# web_page.sheet_name = 'test100_products'
# web_page.save

# web page 2
web_page = WebPage.new
web_page.website_id = website.id
web_page.url = 'http://www.episcopalacademy.org/directory'
web_page.next_page_link_path = '.fsNextPageLink'
web_page.pagination_links_parent_path = ''
web_page.pagination_links_path = ''
web_page.products_parent_path = '.fsConstituentColumnLayout_2 .fsConstituentItem'
web_page.products_link_path = '.fsFullName .fsConstituentProfileLink'
web_page.file_name = 'staff_contact_information.xlsx'
web_page.sheet_name = 'contact_info'
web_page.save

# Page content 1

page_content = PageContent.new
page_content.content_field = 'Prefix'
page_content.content_path = '.fsFullNamePrefix'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'First Name'
page_content.content_path = '.fsFullNameFirst'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'Last Name'
page_content.content_path = '.fsFullNameLast'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'Department(s)'
page_content.content_path = '.fsDepartment .fsProfileSectionFieldValue'
page_content.web_page_id = web_page.id
page_content.save


page_content = PageContent.new
page_content.content_field = 'Title(s)'
page_content.content_path = '.fsTitle .fsProfileSectionFieldValue'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'School Email'
page_content.content_path = '.fsEmail div:last'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'School Phone'
page_content.content_path = '.fsPhone div:last'
page_content.web_page_id = web_page.id
page_content.save