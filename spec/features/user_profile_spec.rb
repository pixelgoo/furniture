require 'rails_helper'

feature "[settings] Manufacturer can" do

  before(:each) do
    create(:user, role_name: 'Manufacturer', email: "login@example.com", password: "123456", confirmed_at: DateTime.now)
    visit "/"
    click_link "sign_in"
    fill_in "user_email", with: "login@example.com"
    fill_in "user_password", with: "123456"
    form = find '#login'
    page.submit form
  end

  scenario "select his regions from list" do
    product = create_list(:region, 20)
    visit "/profile"

    check 'set_region_3'

    click_button 'submit-regions'

    expect(User.last.regions.first).to eq(Region.find(3))
  end

end
