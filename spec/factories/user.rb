FactoryBot.define do
  factory :user, class: User do |u|
    username { Faker::Name.name }
    u.sequence(:email) { |n| "user#{n}@gmail.com" }
    password { "123456" }
  end

  factory :admin, class: User do
    username { "Admin" }
    email { "admin@gmail.com" }
    password { "123456" }
    admin { true }
  end

  factory :user1, class: User do
    username { "User 1" }
    email { "user@gmail.com" }
    password { "123456" }
  end

  factory :user2, class: User do
    username { "User 2" }
    email { "user1@gmail.com" }
    password { "123456" }
  end
end
