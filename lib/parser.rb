require 'watir'
require 'selenium-webdriver'
# require 'chromedriver/helper'
require 'open-uri'
require 'fileutils'

def parse_item(browser, link, catalog)
  parsed_item = {}

  parsed_item['id'] = link[/\d+$/].to_i
  parsed_item['title'] = browser.div(:class, 'breadcrumbs').h1(:class, 'title').inner_html

  browser.div(:class, 'features').divs(:class, 'item').each do |item|

    if item.div(:class, 'value').inner_html.include?('<i')
      params = item.div(:class, 'value').inner_html.scan(/(\d+)/i) 
      
      if params.length == 3 
        parsed_item[item.div(:class, 'name').inner_html.chomp(':')] = [
        'width' => params[0][0].to_i,
        'height' => params[1][0].to_i,
        'depth' => params[2][0].to_i
        ]
      elsif params.length == 2
        parsed_item[item.div(:class, 'name').inner_html.chomp(':')] = [
        'width' => params[0][0].to_i,
        'depth' => params[1][0].to_i
        ]
      end

    else
      parsed_item[item.div(:class, 'name').inner_html.chomp(':')] = item.div(:class, 'value').inner_html
    end

  end
  puts "Item data parsed: #{parsed_item['title']}"

  data = {}
  FileUtils.mkdir_p "./assets/#{catalog}/#{parsed_item['id']}"
  File.open("./products/#{catalog}/#{catalog}.json",'r') do |f|
    data = JSON.parse(f.read)
  end

  data['products'].push parsed_item

  File.open("./products/#{catalog}/#{catalog}.json",'w+') do |f|
    f.write JSON.pretty_generate(data)
  end

  FileUtils.mkdir_p "./assets/#{catalog}/#{parsed_item['id']}"

  # Download images
  browser.div(:class, 'photo').imgs(:class, 'item-image').each_with_index do |image, index|
    image_link = image.attribute_value('src')
    puts "Image link: #{image_link}"
    if image_link.include? "http" then
      image = open image_link
      bytes_expected = image.meta['content-length'].to_i
      place = Dir.pwd + "/temp"
      bytes_copied = IO.copy_stream image, place
      if bytes_expected == bytes_copied then
        puts "Image downloaded" 
      else 
        puts "Image download failed"
      end

      f_image = File.open('temp', 'rb')
      is_png = f_image.read.include?('PNG')
      f_image.close
      is_png ? FileUtils.mv('temp', Dir.pwd + "/assets/#{catalog}/#{parsed_item['id']}/#{parsed_item['id']}_#{index}.png")
      : FileUtils.mv('temp', Dir.pwd + "/assets/#{catalog}/#{parsed_item['id']}/#{parsed_item['id']}_#{index}.jpg")

    end
  end

  puts "Item images parsed. Moving on!"

  return parsed_item
end

def scan_page_links(browser)
  items = browser.div(:class => "catalog").divs(:class => "item")

  page_items_links = Array.new(items.size) do |i|
    items[i].a.attribute_value('href')
  end
  
  puts "#{items.size} links collected, trying to visit next page..."
  return page_items_links
end

# ============================================================================

# An array of required catalogs got through console arguments
ARGV.map(&:to_i)
catalogs = ARGV

# Parse items for each catalog
catalogs.each do |catalog|
  catalog_data = { "id": catalog, "products": [] }

  FileUtils.mkdir_p "products/#{catalog}"
  File.open("./products/#{catalog}/#{catalog}.json",'w') do |f|
    f.write JSON.pretty_generate(JSON.parse "{ \"id\": #{catalog}, \"products\": [] }")
  end
  
  browser = Watir::Browser.new
  puts "Chromedriver found, opening browser..."

  browser.goto "https://www.dybok.com.ua/ru/product/catalog/#{catalog}"

  puts "Parsing catalog ##{catalog}: #{browser.div(:class => "content").div(:class => "breadcrumbs").h1(:class => "title").inner_html}"

  # Parse links from the first page then loop other pages until 404
  puts "Collecting product links"

  pages = []
  pages.push scan_page_links(browser)
  
  page_number = 2
  loop do
    browser.goto "https://www.dybok.com.ua/ru/product/catalog/#{catalog}/page=#{page_number}"
    break if browser.url != "https://www.dybok.com.ua/ru/404"
    pages.push scan_page_links(browser)
    page_number += 1
  end

  puts "Begin parsing process:"
  pages.each do |page|
    page.each do |link|
      browser.goto link
      catalog_data[:products].push(parse_item(browser, link, catalog))
    end
  end
  
  browser.close

  puts "Catalog ##{catalog} is parsed. Data written in ./products/#{catalog}/#{catalog}.json. Images placed to ./products/#{catalog}/. Yay!"

end
