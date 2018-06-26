FactoryBot.define do

  sequence :email do |n|
      "person#{n}@example.com"
  end

  factory :user do
      first_name "User"
      company "Company"
      email
      password "123456"
      password_confirmation "123456"
      role
      documents_confirmed true
  end

end