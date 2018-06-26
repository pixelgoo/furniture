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

  scenario "not see request due to Tariff restriction" do
    user = User.last
    tariff = create(:tariff, name: 'Tariff_1', request_visibility: 10)
    user.set_tariff('Tariff_1')
    create(:product)
    create(:request)

    visit "/requests/new"

    expect(page).to have_content(I18n.t('request.no-requests'))
  end

  scenario "see request when Tariff restriction over" do
    user = User.last
    tariff = create(:tariff, name: 'Tariff_1', request_visibility: 0)
    user.set_tariff('Tariff_1')
    create(:product)
    create(:request)

    visit "/requests/new"

    expect(page).to have_content('Nice Couch')
  end

end
