require 'rails_helper'

feature "User can login" do

  scenario "with valid details" do
    create(:user, role_name: 'Manufacturer')
    
    visit "/"

    click_link "sign_in"
    expect(current_path).to eq(new_user_session_path)

    fill_in "user_email", with: "person1@example.com"
    fill_in "user_password", with: "123456"

    #TODO:
    #click_on('Log in')

    #expect(page).to have_selector ".alert-success"
  end

end
