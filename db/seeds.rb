require 'csv'

Customer.destroy_all
Merchant.destroy_all
Item.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all


CSV.foreach("./db/data/customers.csv", :headers => true) do |row|
 Customer.create(row.to_h)
end

CSV.foreach("./db/data/merchants.csv", :headers => true) do |row|
 Merchant.create(row.to_h)
end

CSV.foreach("./db/data/items.csv", :headers => true) do |row|
  Item.create!(row.to_hash)
end

CSV.foreach("./db/data/invoices.csv", :headers => true) do |row|
  Invoice.create!(row.to_hash)
end

CSV.foreach("./db/data/invoice_items.csv", :headers => true) do |row|
  InvoiceItem.create!(row.to_hash)
end
