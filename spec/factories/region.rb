FactoryBot.define do
  
  sequence :name do |n|
    "Region#{n}"
  end

  factory :region do
    name
  end

end
