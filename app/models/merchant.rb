class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.most_revenue(top_x)
    Merchant.unscoped
    .joins(:invoices)
    .joins(invoices: [:transactions])
      .where(transactions: {result: "success"})
    .joins(invoices: [:invoice_items])
    .group(:id)
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .reorder('total_revenue DESC')
    .limit(top_x)
  end
end
