require 'rails_helper'

feature "User" do

  scenario "is not valid initially" do
    user = User.new()
    expect(user).to_not be_valid
  end

  scenario "is valid with nesseccary atributes" do
    expect(create(:user)).to be_valid
  end

  scenario "model is monetized with :uah account" do
    expect(User).to monetize(:account).with_currency(:uah)
  end

  scenario "has 0 UAH initially" do
    expect(create(:user).account).to eq(0)
  end

  scenario "has role initially" do
    role = create(:role)
    user = create(:user)
    expect(user.role.name).to eq('Role')
  end

  scenario "can have a tariff" do
    role = create(:role)
    user = create(:user)
    p user.tariff.price.methods 
    expect(user.tariff.price).to eq(100)
  end
end
