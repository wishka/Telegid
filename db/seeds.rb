Customer# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create!(name:  "Example Customer",
             email: "exale@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

20.times do |n|
  name  = Faker::Name.name
  email = "exale-#{n+1}@example.com"
  password = "password"
  Customer.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Взаимоотношения
customers = Customer.all
customer  = customers.first
following = customers[2..50]
followers = customers[3..40]
following.each { |followed| customer.follow(followed) }
followers.each { |follower| follower.follow(customer) }
Room.create!(name: "Зарядка для ума",
             city: "Не имеет значение",
             content: "Регулярные тренировки мозга позволяют ему работать
             четко и отлаженно на протяжении всей жизни.",
             link: "https://t.me/zaryadkauma",
             image: "",
             carousel: true)
Room.create!(name: "Learn English",
            city: "Не имеет значение",
            content: "Книги на английском для взрослых и детей.",
            link: "https://t.me/fairytaleseng",
            image: "",
            carousel: true)
Room.create!(name: "Крутая мама",
             city: "Не имеет значение",
             content: "У нас  крутые мастер классы с
             использованием цветной бумаги , пластилина , картона,
             природных материалов и много другого. Скучать не придется.",
             link: "https://t.me/mamakrutayaa",
             image: "",
             carousel: true)
