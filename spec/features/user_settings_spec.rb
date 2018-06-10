require 'rails_helper'

feature "[settings] User can" do

  before(:each) do
    create(:user, role_name: 'Customer', email: "login@example.com", password: "123456", confirmed_at: DateTime.now)
    visit "/"
    click_link "sign_in"
    fill_in "user_email", with: "login@example.com"
    fill_in "user_password", with: "123456"
    form = find '#login'
    page.submit form
  end

  scenario "select his regions from list" do
    product = create_list(:region, 20)
    visit "/settings"

    check 'set_region_1'
    check 'set_region_3'
    check 'set_region_15'
    

    expect(Request.last.customer).to eq(User.last)
    expect(Request.last.product).to eq(product)
  end

end
