# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all

User.create!(first_name: "Cem", surname: "KIRAY", email: "jamcry@hotmail.com", password: "foobar", birthday: Date.new, gender_id: 0)

10.times {
  u = User.create!(first_name: Faker::Name.first_name,
                   surname:    Faker::Name.last_name,
                   email:      Faker::Internet.email,
                   birthday:   Faker::Date.birthday(18, 50),
                   password:   "foobar",
                   gender_id:  rand(0..2))
  rand(1..5).times {
    u.make_friends_with(User.find(rand((User.first.id)..(User.last.id))))
  }
  rand(1..35).times {
    p = u.posts.create!(body: Faker::Quote.famous_last_words)
    rand(1..15).times {
      p.comments.create!(body: Faker::Quote.most_interesting_man_in_the_world,
                         user: User.find(rand((User.first.id)..(User.last.id))))
    }
  }
}