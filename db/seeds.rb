# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

City.create!([
  {name: "Delhi", lat: 28.7041, lng: 77.1025, photo_url: "https://upload.wikimedia.org/wikipedia/commons/0/02/India_Gate-5.jpg", time_zone_name: "Asia/Kolkata"}
])
Neighborhood.create!([
  {name: "Delhi", city_id: 1, lat: 28.7041, lng: 77.1025, entire_city: false},
  {name: "Noida", city_id: 1, lat: 28.5355, lng: 77.3910, entire_city: false}
])
Category.create!([
    {name: 'Save Time'},
	{name: 'Do Better'},
	{name: 'Show Love'},
	{name: 'Have Fun'},
	{name: 'Feel Good'},
	{name: 'Make Stuff'},
	{name: 'Explore Places'}
])
