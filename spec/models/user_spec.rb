require 'rails_helper'

feature "User" do

  scenario "is not valid initially" do
    user = User.new()
    expect(user).to_not be_valid
  end

end
