class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  scope :by_date, lambda { |date|
    return nil unless date.present?
    where(invoices: {created_at: date})
  }

  def total_revenue(date = nil)
    self.invoices.joins(:invoice_items, :transactions).merge(Transaction.success).merge(Merchant.by_date(date)).sum("invoice_items.unit_price * invoice_items.quantity")
  end
end

