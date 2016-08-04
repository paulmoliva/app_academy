# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Cat.create!(name: "Jim", birth_date: "01/01/2010",sex: "M", color: "Black",
  description: "Cool cat")

Cat.create!(name: "Larry", birth_date: "01/01/2008",sex: "M", color: "Orange",
    description: "Kind of shy")

Cat.create!(name: "Lisa", birth_date: "01/01/2006",sex: "F", color: "White",
  description: "fun cat")

CatRentalRequest.create!(cat_id: 1, start_date: "1/9/2016", end_date: "1/10/2016", status: "APPROVED")

CatRentalRequest.create!(cat_id: 1, start_date: "15/9/2016", end_date: "15/10/2016")

CatRentalRequest.create!(cat_id: 2, start_date: "01/8/2016", end_date: "15/8/2016")

CatRentalRequest.create!(cat_id: 3, start_date: "1/9/2016", end_date: "1/10/2016")
