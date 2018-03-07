require 'rails_helper'

feature "Static page controller" do

  scenario "renders home page with sign_up button" do
    visit "/"
    expect(page).to have_selector('#sign_up')
  end

end
