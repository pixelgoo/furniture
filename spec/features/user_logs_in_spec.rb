require 'rails_helper'

feature "User can login" do

  scenario "with valid details" do
    create(:user, role_name: 'Manufacturer')
    
    # TODO:
    p User.all
    visit "/"

    click_link "sign_in"
    expect(current_path).to eq(new_user_session_path)

    fill_in "user_email", with: "person1@example.com"
    fill_in "user_password", with: "123456"

    within '.actions' do
      find('[type="submit"]').click
    end

    p current_path
    expect(page).to have_selector ".alert-success"
  end

end
