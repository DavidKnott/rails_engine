class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :customer
      t.text :status
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
