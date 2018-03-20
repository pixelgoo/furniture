require 'rails_helper'

feature "Category" do

  scenario "is not valid without furniture" do
    expect(Category.new(title: 'Chairs')).to_not be_valid
  end

  scenario "can have multiple products" do
    expect(create(:category_with_products).products.length).to eq(10)
    expect(create(:category_with_products, products_count: 15).products.length).to eq(15)
  end
  
end
