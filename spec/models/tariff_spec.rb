require 'rails_helper'

feature "Tariff" do

  scenario "cah have many users" do
    tariff = create(:tariff)
    create_list(:user, 5, tariff: tariff)
    
    expect(tariff.users.length).to eq(5)
  end

end
