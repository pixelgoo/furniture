require 'rails_helper'

feature "[requests] User can" do

  scenario "create request from product page" do
    user = login_as('Customer')
    product = create(:product)
    visit "/products/#{product.id}"

    click_button I18n.t('button.request')

    expect(Request.last.customer).to eq(user)
    expect(Request.last.product).to eq(product)
  end

  scenario "not see request due to Tariff restriction" do
    user = login_as('Customer')
    create(:product)
    create(:request)
    tariff = create(:tariff, name: 'Tariff_1', request_visibility: 10)
    user.set_tariff(tariff.name)

    visit "/requests/new"

    expect(page).to have_content(I18n.t('request.no-requests'))
  end

  scenario "see request when Tariff restriction over" do
    user = login_as('Customer')
    create_visible_requests(user)
    tariff = create(:tariff, name: 'Tariff_2', request_visibility: 0)
    user.set_tariff(tariff.name)

    visit "/requests/new"

    expect(page).to have_content('Nice Couch')
  end

  scenario "can not see requests when trial over" do
    user = login_as('Customer', 0)
    create_visible_requests(user)

    visit "/requests/new"

    expect(page).to have_content(I18n.t('request.trial_over'))
  end

end
