require 'watir'
require 'selenium-webdriver'
# require 'chromedriver/helper'
require 'open-uri'
require 'fileutils'

def parse_item(browser, link)
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

    elsif

    else
      parsed_item[item.div(:class, 'name').inner_html.chomp(':')] = item.div(:class, 'value').inner_html
    end

  end

  p "Item parsed: #{parsed_item}"

  return parsed_item
end

# ============================================================================

# An array of required catalogs
catalogs = [ 57 ]

# All products will be written into this
products = {}

catalogs.each do |catalog|
  products[catalog] = []
end

# Parse items for each catalog
catalogs.each do |catalog|
  browser = Watir::Browser.new
  browser.goto "https://www.dybok.com.ua/ru/product/catalog/#{catalog}"
  
  products[catalog].push({ 'catalog_title' => browser.div(:class => "content").div(:class => "breadcrumbs").h1(:class => "title").inner_html })
  p "Parsing catalog ##{catalog}: #{products[catalog][0]['catalog_title']}"

  items = browser.div(:class => "catalog").divs(:class => "item")

  page_items_links = Array.new(items.size) do |i|
    items[i].a.attribute_value('href')
  end

  page_items_links.each do |link|
    browser.goto link
    products[catalog].push(parse_item(browser, link))
  end
  
  browser.close
end

# Write results
File.open('products.json','w') do |f|
  f.write(JSON.pretty_generate(products))
end
