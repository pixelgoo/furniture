require 'rails_helper'

feature "Role" do

  scenario "cah have many users" do
    create(:role)
    create_list(:user, 5)

    expect(User.all.length).to eq(5)
  end
  
end
