class CreateInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_items do |t|
      t.references :item
      t.references :invoice
      t.integer :quantity
      t.integer :unit_price
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
