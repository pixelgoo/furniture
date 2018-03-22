FactoryBot.define do
  
  factory :payment do
    request
    action "pay"
    amount 1
    confirm "yes"
  end

end
