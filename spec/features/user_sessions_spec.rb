require 'rails_helper'

feature "[sessions] User" do

  scenario "can login with valid details" do
    create(:user, role_name: 'Manufacturer', email: "login@example.com", password: "123456", confirmed_at: DateTime.now)
    
    visit "/"

    click_link "sign_in"
    expect(current_path).to eq(new_user_session_path)

    fill_in "user_email", with: "login@example.com"
    fill_in "user_password", with: "123456"

    form = find '#login'
    page.submit form

    expect(page).to have_link(href: destroy_user_session_path)
  end

  scenario "can sign up with valid details" do
    visit "/"

    click_link "sign_up"
    expect(current_path).to eq(new_user_registration_path)

    fill_in "customer_first_name", with: "Tony"
    fill_in "customer_last_name", with: "Example"
    fill_in "customer_phone", with: "+3809999999"
    fill_in "customer_email", with: "tester@example.tld"
    fill_in "customer_city", with: "Kiev"
    fill_in "customer_password", with: "123456"
    fill_in "customer_password_confirmation", with: "123456"

    form = find '#registrationCustomer'
    page.submit form

    expect(current_path).to eq "/"

    expect(User.last.email).to eq "tester@example.tld"
  end

  scenario "has all Furnitures after sign up if it's Manufacturer" do
    visit "/"

    click_link "sign_up"
    expect(current_path).to eq(new_user_registration_path)

    fill_in "manufacturer_first_name", with: "Tony"
    fill_in "manufacturer_last_name", with: "Example"
    fill_in "manufacturer_phone", with: "+3809999999"
    fill_in "manufacturer_email", with: "tester@example.tld"
    fill_in "manufacturer_city", with: "Kiev"
    fill_in "manufacturer_password", with: "123456"
    fill_in "manufacturer_password_confirmation", with: "123456"

    form = find '#registrationManufacturer'
    page.submit form

    expect(User.last.furnitures).to eq Furniture.all
  end
  
  scenario "doesn't have Furnitures if its Customer" do
    visit "/"

    click_link "sign_up"
    expect(current_path).to eq(new_user_registration_path)

    fill_in "customer_first_name", with: "Tony"
    fill_in "customer_last_name", with: "Example"
    fill_in "customer_phone", with: "+3809999999"
    fill_in "customer_email", with: "tester@example.tld"
    fill_in "customer_city", with: "Kiev"
    fill_in "customer_password", with: "123456"
    fill_in "customer_password_confirmation", with: "123456"

    form = find '#registrationCustomer'
    page.submit form

    expect(User.last.furnitures).to eq Furniture.none
  end
end
