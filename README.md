# README

## Overview of Rails Engine API
Rails Engine utilizes a multi-merchant sales dataset, including data on merchants, customers, items, invoices, and transactions. The project includes a 6-table postgresql database built in Ruby on Rails 5. The API provides many relationship and business intelligence queries accessible via the available routes ([See Available Routes](#routes)).

### Database Diagram
[diagram]: https://github.com/DavidKnott/rails_engine/blob/master/rails_engine_database_diagram.png "Rails Engine Database Diagram"

### What to Expect
  - All endpoints will return JSON data
  - All endpoints are exposed under an api and version (v1) namespace (e.g. /api/v1/merchants.json)

## Setup Instructions
Run these commands in this order:
```
git clone XXX
cd rails_engine
rails db:create
rails db:migrate
rails db:seed
rails db:test:prepare
```

## Deployment Instructions
To launch the project on local host, start up the rails server and visit any of the routes listed below.
```
rails s
```
### <a name="routes"></a> API Routes Available

####Merchants
  - **/api/v1/merchants/:id/items** - returns a collection of items associated with that merchant
  - **/api/v1/merchants/:id/items** - returns a collection of items associated with that merchant
  - **/api/v1/merchants/:id/invoices** - returns a collection of invoices associated with that merchant from their known
  - **/api/v1/merchants/revenue?date=x** returns the total revenue for date x across all merchants
  - **/api/v1/merchants/:id/revenue** - returns the total revenue for that merchant across all transactions
  - **/api/v1/merchants/:id/revenue?date=x** - returns the total revenue for that merchant for a specific invoice date x
  - **/api/v1/merchants/:id/favorite_customer** - returns the customer with the highest count of succesful transactions associated with that merchant
  - **/api/v1/merchants/:id/customers_with_pending_invoices** - returns a collection of customers which have pending invoices.
    * **NOTE:** A pending invoice is defined as an invoice that has no transactions with a result of success. This means all transactions are failed.
  - **/api/v1/merchants/most_revenue?quantity=x** - returns the top x merchants ranked by total revenue
  - **/api/v1/merchants/most_items?quantity=x** returns the top x merchants ranked by total number of items sold

####Items
  - **/api/v1/items/:id/invoice_items** returns a collection of associated invoice items
  - **/api/v1/items/:id/merchant** returns the associated merchant
  - **/api/v1/items/:id/best_day** returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, the most recent day is returned.
  - **/api/v1/items/most_revenue?quantity=x** returns the top x items ranked by total revenue generated
  - **/api/v1/items/most_items?quantity=x** returns the top x item instances ranked by total number sold

####Customers
  - **/api/v1/customers/:id/invoices** - returns a collection of associated invoices
  - **/api/v1/customers/:id/transactions** - returns a collection of associated transactions
  - **/api/v1/customers/:id/favorite_merchant** - returns a merchant where the customer has conducted the most successful transactions

####Invoices
  - **/api/v1/invoices/:id/transactions** - returns a collection of associated transactions
  - **/api/v1/invoices/:id/invoice_items** returns a collection of associated invoice items
  - **/api/v1/invoices/:id/items** returns a collection of associated items
  - **/api/v1/invoices/:id/customer** returns the associated customer
  - **/api/v1/invoices/:id/merchant** returns the associated merchant

####Invoice Items
  - **/api/v1/invoice_items/:id/invoice** - returns the associated invoice
  - **/api/v1/invoice_items/:id/item** returns the associated item

####Transactions
  - **/api/v1/transactions/:id/invoice** returns the associated invoice

####Important Notes
  - The dates provided match the format of a standard ActiveRecord timestamp.
  - Failed charges are never counted in revenue totals or statistics.
  - All revenues are reported as a float with two decimal places, but prices are stored as integers.
  

## How to Run the Test Suite
Run rspec from the command line:
```
rspec
```
