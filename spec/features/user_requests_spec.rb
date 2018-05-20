require 'rails_helper'

feature "[requests] User can" do

  before(:each) do
    create(:user, role_name: 'Customer', email: "login@example.com", password: "123456", confirmed_at: DateTime.now)
    visit "/"
    click_link "sign_in"
    fill_in "user_email", with: "login@example.com"
    fill_in "user_password", with: "123456"
    form = find '#login'
    page.submit form
  end

  scenario "create request from product page" do
    product = create(:product)
    visit "/products/#{product.id}"

    click_button I18n.t('button.request')

    expect(Request.last.customer).to eq(User.last)
    expect(Request.last.product).to eq(product)
  end

end
