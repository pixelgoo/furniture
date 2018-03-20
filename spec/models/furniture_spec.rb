require 'rails_helper'

feature "Furniture" do

  scenario "can have multiple categories" do
    furniture = create(:furniture)
    expect(create_list(:category, 10, furniture: furniture).length).to eq(10)
  end
  
end
