require 'rails_helper'

feature "[settings] Manufacturer can" do

  scenario "select his regions from list" do
    user = login_as('Manufacturer')
    product = create_list(:region, 20)
    visit "/profile"

    check 'set_model_region_3'

    click_button 'submit-regions'

    expect(user.regions.first).to eq(Region.find(3))
  end

end
