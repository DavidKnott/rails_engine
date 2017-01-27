class Invoice < ApplicationRecord
  validates :customer, presence: true
  validates :status, presence: true

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant

  # default_scope { order(:id)}
end
# i.invoices.joins(:transactions, :invoice_items).where(transactions: {result: 'success'}).group('invoices.id, invoices.created_at').select('invoices.created_at').order('sum(invoice_items.quantity), invoices.created_at desc')