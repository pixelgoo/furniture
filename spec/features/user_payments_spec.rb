require 'rails_helper'

feature "[payments] Manufacturer can" do

  before(:each) do
    create(:user, role_name: 'Manufacturer', email: "login@example.com", password: "123456", confirmed_at: DateTime.now)
    visit "/"
    click_link "sign_in"
    fill_in "user_email", with: "login@example.com"
    fill_in "user_password", with: "123456"
    form = find '#login'
    page.submit form
  end
  
  scenario "subscribe to Tariff" do
    user = User.last
    tariff = create(:tariff)

    visit "/profile"
    expect(page).to have_xpath("//a[@href='/settings']")
    visit "/settings"
    expect(page).to have_content(I18n.t('button.subscribe'))

    # Liqpay payment here actually
    user.set_tariff(tariff.name)

    visit "/profile"
    expect(page).to have_content(user.tariff_enddate.strftime("%d-%m-%Y"))
  end

end
