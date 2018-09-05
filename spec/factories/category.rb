FactoryBot.define do
  factory :category_1, class: Category do
    title { "Category 1" }
    description { "Category description" }
  end

  factory :category_2, class: Category do
    title { "Category 2" }
    description { "Category description" }
  end
end
