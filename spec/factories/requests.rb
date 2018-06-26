FactoryBot.define do

  factory :request do
    association :customer, factory: :user
    product
  end

end
