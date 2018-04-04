require 'watir'
require 'selenium-webdriver'
# require 'chromedriver/helper'
require 'open-uri'
require 'fileutils'
require 'securerandom'

def parse_item(browser, link, catalog)
  parsed_item = {}

  parsed_item['id'] = link[/\d+$/].to_i
  parsed_item['title'] = browser.div(:class, 'breadcrumbs').h1(:class, 'title').inner_html

  puts "Parsing item: #{parsed_item['title']}"

  # Parse general data
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
  
  FileUtils.mkdir_p "assets/#{catalog}/#{parsed_item['id']}"

  # Parse textiles
  puts "Parsing item textiles..."
  parsed_item['textiles'] = []
  if browser.div(:class, 'product_color').exists? then
    browser.div(:class, 'product_color').divs(:class, 'item').each do |textile|
      name = textile.a(:class, 'link').img(:class, 'item-image').attribute_value('alt').gsub!('/', ',')
      name = SecureRandom.urlsafe_base64(8) if name.nil? || name.empty?
      parsed_item['textiles'].push name
      
      from = textile.a(:class, 'link').img(:class, 'item-image').attribute_value('src')
      to = "/assets/textiles/#{name}"
      puts "    #{name}"
      download_image(from, to)
    end
  else
    puts "No textiles for this item!"
  end

  puts "✔️ ✔️ ✔️  Item data parsed!"
  # ==========================================================================================

  browser.div(:class, 'photo').imgs(:class, 'item-image').each_with_index do |image, index|
    from = image.attribute_value('src')
    to = "/assets/#{catalog}/#{parsed_item['id']}/#{parsed_item['id']}_#{index}"
    download_image(from, to)
  end

  puts "✔️ ✔️ ✔️  Item images parsed. Moving on! 🎉"
  # ==========================================================================================

  return parsed_item
end

# ==========================================================================================

def download_image(from, to)
  if from.include? 'http' then
    image = open from
    bytes_expected = image.meta['content-length'].to_i
    place = Dir.pwd + "/temp"
    bytes_copied = IO.copy_stream image, place
    if bytes_expected == bytes_copied then
      puts "   ✨  Image downloaded" 
    else 
      puts "🚨🚨🚨  Image download failed, image link: #{from}"
      return
    end
    f_image = File.open('temp', 'rb')
    image_type = f_image.read.include?('PNG') ? ".png" : ".jpg"
    f_image.close
    FileUtils.mv('temp', Dir.pwd + to + image_type)
  else
    File.open('temp', 'wb') do |f|
      f.write(Base64.decode64(from[/base64,(.+)/, 1]))
    end
    FileUtils.mv('temp', Dir.pwd + to + "." + from[/image\/([a-zA-Z]*);base64,/, 1])
    puts "   ✨  Image downloaded" 
  end
end

def scan_page_links(browser)
  items = browser.div(:class => "catalog").divs(:class => "item")

  page_items_links = Array.new(items.size) do |i|
    items[i].a.attribute_value('href')
  end
  
  puts "#{items.size} links collected  👌  trying to visit next page..."
  return page_items_links
end

# ==========================================================================================

# An array of required catalogs received through console arguments
ARGV.map(&:to_i)
catalogs = ARGV

# Downloaded textiles come here
FileUtils.mkdir_p "./assets/textiles"

# Parse items for each catalog
catalogs.each do |catalog|
  catalog_data = {
    :id => catalog, 
    :products => [] 
  }

  FileUtils.mkdir_p "products/#{catalog}"
  FileUtils.mkdir_p "assets/#{catalog}"

  browser = Watir::Browser.new
  puts "🚀  Chromedriver found, opening browser..."

  browser.goto "https://www.dybok.com.ua/ru/product/catalog/#{catalog}"

  puts "🔮  Parsing catalog ##{catalog}: #{browser.div(:class => "content").div(:class => "breadcrumbs").h1(:class => "title").inner_html}"

  # Parse links from the first page then loop other pages until 404
  puts "Collecting product links"

  pages = []
  pages.push scan_page_links(browser)
  
  page_number = 2
  loop do
    browser.goto "https://www.dybok.com.ua/ru/product/catalog/#{catalog}/page=#{page_number}"
    break if browser.url == "https://www.dybok.com.ua/ru/404"
    pages.push scan_page_links(browser)
    page_number += 1
  end

  puts "👷  Begin parsing process:"
  pages.each do |page|
    page.each do |link|
      browser.goto link
      catalog_data[:products].push(parse_item(browser, link, catalog))
    end
  end
  
  browser.close

  File.open("./products/#{catalog}/#{catalog}.json",'w+') do |f|
    f.write JSON.pretty_generate(catalog_data)
  end
  
  puts "Catalog length is #{catalog_data[:products].length}"
  puts "✅  Catalog ##{catalog} is parsed. Data written in ./products/#{catalog}/#{catalog}.json. Images placed to ./products/#{catalog}/. Yay 🐎!"

end
