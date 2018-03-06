require 'rails_helper'

feature "Category" do

  scenario "can have multiple products" do
    expect(create(:category_with_products).products.length).to eq(10)
    expect(create(:category_with_products, products_count: 15).products.length).to eq(15)
  end

  scenario "is valid with category id" do
    category = Category.new(id: 33)
    category.save
    product = Product.new(category_id: 33)
    expect(product).to be_valid
  end

end
