# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach("./db/data/customers.csv", :headers => true) do |row|
  Customer.create(row.to_h)
end

CSV.foreach("./db/data/merchants.csv", :headers => true) do |row|
  Merchant.create(row.to_h)
end
