User.create! username: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             avatar: "",
             password_confirmation: "foobar",
             role: 1,
             admin: true

10.times do |n|
  title = Faker::Lorem.sentence 2
  description = Faker::Lorem.sentence 10
  Category.create! title: title, description: description
end
