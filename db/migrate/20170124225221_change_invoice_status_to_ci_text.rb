class ChangeInvoiceStatusToCiText < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :status
    add_column :invoices, :status, :citext
  end
end
