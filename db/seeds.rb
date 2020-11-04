# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'admin@gmail.com', password: 'admin123', password_confirmation: 'admin123', admin: true)
25.times do |i|
  post = Post.new
  post.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
  post.content = Faker::Lorem.paragraph_by_chars(number: 1500)
  post.user = User.first
  post.picture.attach(io: open("https://cdn.pixabay.com/photo/2015/05/31/15/07/business-792113_1280.jpg"), filename: "picture_#{i}.jpg")
  post.banner.attach(io: open("https://cdn.pixabay.com/photo/2018/09/24/13/54/roses-3699995_1280.jpg"), filename: "banner_#{i}.jpg")
  
  post.save!
end