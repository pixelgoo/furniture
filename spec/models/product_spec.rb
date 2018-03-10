require 'rails_helper'

feature "Product" do

  scenario "is not valid without category" do
    expect(Product.new(title: 'Cool thing')).to_not be_valid
  end
  
end
