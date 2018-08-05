FactoryBot.define do
  
  sequence :title do |n|
    "Region#{n}"
  end

  factory :region do
    title
  end

end
