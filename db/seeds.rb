User.create! username: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             avatar: "",
             password_confirmation: "foobar",
             role: 1,
             admin: true

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

Category.create!([{
  title: "Ruby",
  description: "Ruby là một ngôn ngữ lập trình hướng đối tượng,
    có khả năng phản ứng. Theo tác giả, Ruby chịu ảnh hưởng bởi Perl, Smalltalk,
    Eiffel, Ada và Lisp. Ruby là ngôn ngữ thông dịch và hướng đối tượng."
},
{
  title: "Ruby on Rails",
  description: "Ruby On rails là một Framework cho phép phát triển ứng dụng Web
    gồm 2 phần cơ bản: Phần ngôn ngữ Ruby: “Ruby là một ngôn lập trình mã
    nguồn mở, linh hoạt, với một sự nổi bật về sự đơn giản dễ dùng và hữu ích.
    Nó có cú pháp “tao nhã” và tự nhiên dễ đọc và dễ dàng để viết”."
},
{
  title: "PHP",
  description: "PHP là một ngôn ngữ lập trình kịch bản hay một loại mã lệnh
    chủ yếu được dùng để phát triển các ứng dụng viết cho máy chủ,
    mã nguồn mở, dùng cho mục đích tổng quát. Nó rất thích hợp với web và
    có thể dễ dàng nhúng vào trang HTML..."
},
{
  title: "MySql",
  description: "MySQL là hệ quản trị cơ sở dữ liệu tự do nguồn mở phổ biến nhất
    thế giới và được các nhà phát triển rất ưa chuộng trong quá trình
    phát triển ứng dụng."
}])

Author.create!([{
  name: "Author 1",
  brith_year: "1978-06-08",
  phone: "0981123123",
  address: "Auhtor address"
},
{
  name: "Author 2",
  brith_year: "1978-06-08",
  phone: "0981123123",
  address: "Auhtor address"
},
{
  name: "Author 3",
  brith_year: "1978-06-08",
  phone: "0981123123",
  address: "Auhtor address"
},
{
  name: "Author 4",
  brith_year: "1978-06-08",
  phone: "0981123123",
  address: "Auhtor address"
},
{
  name: "Author 5",
  brith_year: "1978-06-08",
  phone: "0981123123",
  address: "Auhtor address"
}])
