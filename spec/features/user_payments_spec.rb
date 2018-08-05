require 'rails_helper'

feature "[payments] Manufacturer can" do
  
  scenario "subscribe to Tariff" do
    user = login_as('Manufacturer')

    tariff = create(:tariff)

    visit "/profile"
    expect(page).to have_selector(:css, "section#choose-tariff")
    expect(page).to have_content(I18n.t('button.subscribe'))

    # Liqpay payment here actually
    user.set_tariff(tariff.name)

    visit "/profile"
    expect(page).to have_content(user.tariff_enddate.strftime("%d-%m-%Y"))
  end

end
