require 'rails_helper'

feature "Product" do

  scenario "is not valid without category" do
    expect(Product.new(title: 'Cool thing')).to_not be_valid
  end

  scenario "can have a textile" do
    product = create(:product, textile: create(:textile))
    expect(product.textile.title).to eq("Textile")
  end
  
end
