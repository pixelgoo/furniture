require 'rails_helper'

feature "User payment" do

  scenario "for tariff is successful" do
    visit "/"

    click_link "sign_up"
    expect(current_path).to eq(new_user_registration_path)

    fill_in "user_first_name", with: "Tony"
    fill_in "user_last_name", with: "Example"
    fill_in "user_phone", with: "+3809999999"
    fill_in "user_email", with: "tester@example.tld"
    fill_in "user_city", with: "Kiev"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"

    click_on "user_sign_up"

    expect(current_path).to eq "/"
    expect(page).to have_selector ".alert-success"

    expect(User.last.email).to eq "tester@example.tld"
  end

end
