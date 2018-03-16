require 'rails_helper'

feature "User" do
  include MoneyRails::ActionViewExtension

  scenario "is not valid initially" do
    expect(User.new()).to_not be_valid
  end

  scenario "is invalid with long name" do
    expect(build(:user, first_name: "1234567891012345")).to_not be_valid
  end

  scenario "model is monetized with :uah account" do
    expect(User).to monetize(:account).with_currency(:uah)
  end

  scenario "has 0 UAH initially" do
    expect(create(:user).account).to eq(0)
  end

  scenario "has role initially" do
    user = create(:user, role: create(:role))
    expect(user.role.name).to eq('Role')
  end

  scenario "can have a tariff" do
    user = create(:user, role: create(:role), tariff: create(:tariff))
    expect(humanized_money(user.tariff.price).to_i).to eq(100)
  end

  scenario "can set a tariff" do
    user = create(:user)
    tariff = create(:tariff)
    user.set_tariff('Tariff')

    expect(user.tariff.name).to eq('Tariff')
    expect(user.tariff_active?).to be true
  end

  scenario "has 0 score initially" do
    expect(create(:user).score).to eq(0)
  end
end
