FactoryBot.define do
  factory :author1, class: Author do
    name { "Kevin Yank" }
    brith_year { "1970-05-06" }
    country { "American" }
    biography { "Kevin began developing for the Web in 1995." }
  end

  factory :author2, class: Author do
    name { "Daniel Kehoe" }
    brith_year { "1978-06-08" }
    country { "California" }
    biography { "He's a Senior Ruby on Rails Developer." }
  end
end
