require 'rails_helper'

feature "Product" do

  scenario "is not valid without category" do
    product = Product.new(title: 'Cool thing')
    expect(product).to_not be_valid
  end
  
end
