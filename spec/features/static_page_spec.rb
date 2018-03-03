require 'rails_helper'

feature "PagesController" do
  
  scenario "displays home page" do
      visit "/"
      expect(page).to have_selector("#sign_up")
  end

end