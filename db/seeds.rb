# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all

categories = %w(Indian Chinese Vietnamese Italian Thai Japanese French American)
categories.each do |category|
  Category.create!(name: category)
end

User.delete_all

User.create!(email: "admin@mailinator.com", password: "password", first_name: "Admin", last_name: "Guy", role: "admin")
User.create!(email: "nina@mailinator.com", password: "password", first_name: "Nina", last_name: "Regli")
User.create!(email: "julia@mailinator.com", password: "password", first_name: "Julia", last_name: "Mansson")
User.create!(email: "mat@mailinator.com", password: "password", first_name: "Mathieu", last_name: "Gordon")
User.create!(email: "toni@mailinator.com", password: "password", first_name: "Toni", last_name: "Goncalves", role: "chef", chef_name: "Chef Eusebio", description: "best chef", phone_number: "07899 123 456", address_line_1: "68 Hanbury Street", city: "London", postcode: "E1 5JL", country:"United Kingdom")
User.create!(email: "bob@mailinator.com", password: "password", first_name: "Bob", last_name: "Bobson",role: "chef", chef_name: "Chef Bob", description: "good chef", phone_number: "07777 888 999", address_line_1: "52 Lofting Road", address_line_2: "Islington", city: "London", postcode: "N1 1ET", country:"United Kingdom")
User.create!(email: "dirk@mailinator.com", password: "password", first_name: "Dirk", last_name: "Dirkson", role: "chef", chef_name: "Chef Dirk", description: "chef in training", phone_number: "07890 123 456", address_line_1: "2500 Great Western Road", city: "Glasgow", postcode: "G15 6RW", country:"United Kingdom")
User.create!(email: "michael@mailinator.com", password: "password", first_name: "Michael", last_name: "Pavling", role: "chef", chef_name: "Cool Cool Cool Kitchen", description: "Coder turned coolcoolcool cook", phone_number: "07745221430", address_line_1: "24 Hornton Court", address_line_2: "High Street Kensington", city: "London", postcode: "W8 7RT", country:"United Kingdom")
User.create!(email: "alex@mailinator.com", password: "password", first_name: "Alex", last_name: "Chin", role: "chef", chef_name: "Alex's Bitchin Kitchen", description: "Keen", phone_number: "07956649301", address_line_1: "200 Oxford Street", city: "London", postcode: "W1D 1NU", country:"United Kingdom")
User.create!(email: "jarkyn@mailinator.com", password: "password", first_name: "Jarkyn", last_name: "Soltobaeva", role: "chef", chef_name: "Frying Nemo", description: "specialise in fish", phone_number: "07884354211", address_line_1: "188 Kirtling Street",city: "London", postcode: "SW8 5BN", country:"United Kingdom")
User.create!(email: "johanna@mailinator.com", password: "password", first_name: "Johanna", last_name: "Carlberg", role: "chef", chef_name: "Thai Tanic", description: "keen stir-fryer", phone_number: "07798943544", address_line_1: "748 High Road", address_line_2: "Tottenham", city: "London", postcode: "N17 0AP", country:"United Kingdom")
# User.create!(email: "@mailinator.com", password: "password", first_name: "", last_name: "", role: "chef", chef_name: "", description: "", phone_number: "", address_line_1: "", address_line_2: "", city: "", postcode: "", country:"United Kingdom")















