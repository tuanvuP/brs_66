User.create! username: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             avatar: "",
             password_confirmation: "foobar",
             role: 1
49.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! username: name,
               email: email,
               avatar: "",
               password: password,
               password_confirmation: password,
               role: 0
end

10.times do |n|
  title = Faker::Lorem.sentence 2
  description = Faker::Lorem.sentence 10
  Category.create! title: title, description: description
end

categories = Category.take 6
20.times do
  name = Faker::Lorem.sentence 3
  description = Faker::Lorem.sentence 50
  image = "https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_4th_edition/images/cover-web.png"
  publish_date = Faker::Date.forward 23
  price = Faker::Commerce.price
  categories.each {|category| category.books.create! name: name, description: description, image: image, publish_date: publish_date, price: price}
end
