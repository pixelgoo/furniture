FactoryBot.define do
  
  factory :transaction do
    request
    action "pay"
    amount 1
    confirm "yes"
  end

end
