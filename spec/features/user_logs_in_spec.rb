require 'rails_helper'

feature "User can login" do

  scenario "with valid details" do
    create(:user, role_name: 'Manufacturer', email: "login@example.com", password: "123456", confirmed_at: DateTime.now)
    
    visit "/"

    click_link "sign_in"
    expect(current_path).to eq(new_user_session_path)

    fill_in "user_email", with: "login@example.com"
    fill_in "user_password", with: "123456"

    submit_form

    expect(page).to have_link(href: destroy_user_session_path)
  end

end
