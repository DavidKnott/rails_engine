class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  scope :by_date, lambda { |date|
    return nil unless date.present?
    where(invoices: {created_at: date})
  }

  def total_revenue(date = nil)
    self.invoices
    .joins(:invoice_items, :transactions)
    .merge(Transaction.success)
    .merge(Merchant.by_date(date))
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.all_merchants_revenue_on_date(date)
    Merchant.joins(:invoices)
    .where(invoices: {created_at: date})
    .joins(invoices: [:transactions])
    .where(transactions: {result: "success"})
    .joins(invoices: [:invoice_items])
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.most_items(number_of_merchants)
    Merchant.joins(:invoices)
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .select('merchants.id, merchants.name, SUM(invoice_items.quantity) as quant')
    .order('quant desc')
    .limit(number_of_merchants)
  end

  def self.favorite(customer_id)
    Merchant.joins(:invoices)
    .joins(invoices: [:transactions, :customer])
    .where(transactions: {result: "success"}, customers: {id: customer_id})
    .group(:id)
    .select('merchants.id, merchants.name, COUNT(transactions) as co')
    .order('co desc').first
  end

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
