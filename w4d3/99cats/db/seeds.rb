# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do
  User.create!(username: Faker::Internet.user_name, password: "password")
end

sex = %w(M F)
50.times do
  Cat.create!(name: Faker::Pokemon.name,
              color: Cat::CAT_COLORS.sample,
              sex: sex.sample,
              birth_date: Faker::Date.between(10.years.ago, Date.today),
              user_id: (rand(50) + 1))
end

50.times do
  CatRentalRequest.create(cat_id: (rand(50) + 1),
                          start_date: Faker::Date.between(Date.today, 2.months.from_now),
                          end_date: Faker::Date.between(2.months.from_now, 4.months.from_now),
                          user_id: (rand(50) + 1))
end
