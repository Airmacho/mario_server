# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.destroy_all
Admin.create(name: 'Bowser', credentials: 'GoWork')
Client.destroy_all
Client.create({name: 'Princess Peach', age: 16, private_node: 'nice and shine', address: 'Mushroom Kingdom'})
Client.create({name: 'Princess Dasiy', age: 15, private_node: 'nice and shine', address: 'Mushroom Kingdom'})
Plumber.destroy_all
Plumber.create({name: 'Mario', address: 'Mushroom Kingdom', vehicles: 'Racing Car'})
Plumber.create({name: 'Luigi', address: 'Mushroom Kingdom', vehicles: 'Racing Motor'})
p "seed inserted"