module Helpers
  def login_as(role_name, trial = 14)
    create(:user, role_name: (role_name), email: "#{role_name}@example.com", password: "123456", confirmed_at: DateTime.now, trial: trial)
    visit "/"
    click_link "sign_in"
    fill_in "user_email", with: "#{role_name}@example.com"
    fill_in "user_password", with: "123456"
    form = find '#login'
    page.submit form
    User.last
  end

  def create_visible_requests(user)
    product = create(:product)
    user.furnitures << product.category.furniture
    request = create(:request, product: product)
  end
end