require 'rails_helper'

feature "Role" do

  scenario "can have many users" do
    role = create(:role)
    create_list(:user, 5, role: role)

    expect(role.users.length).to eq(5)
  end
  
end
