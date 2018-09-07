# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


100.times do
  User.create!(
    username: Faker::Internet.username,
    password: 'user'
    )
end


500.times do
  Post.create!(
    user_id: 1 + rand(100),
    body: Faker::GreekPhilosophers.quote
    )
end


250.times do
  Follower.create!(
    user_id: 1 + rand(100),
    follower_id: 1 + rand(100) 
  )
end

250.times do
  Favorite.create!(
    post_id: 1 + rand(500),
    user_id: 1 + rand(100) 
  )
end