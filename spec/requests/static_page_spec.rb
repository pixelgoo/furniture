require 'rails_helper'

RSpec.describe "static page controller", :type => :request do
  it "displays home page" do
    visit "/"
    expect(page).to have_selector(".section#calculator")
  end
end