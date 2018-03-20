FactoryBot.define do

  factory :furniture do
    title "Furniture"
  end

  factory :product do
    title "Nice Couch"
    category
  end

  factory :category do
    title "Couches"
    furniture

    factory :category_with_products do
      
      transient do
        products_count 10
      end

      after(:create) do |category, evaluator|
        create_list(:product, evaluator.products_count, category: category)
      end
    end
  end

end