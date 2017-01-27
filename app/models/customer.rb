class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.pending_invoices(merchant_id)
    Customer.joins(:invoices, :transactions).where(invoices: {merchant_id: merchant_id}).group(:id).where('customers.id NOT IN (?)', (Customer.joins(:invoices).joins(invoices: [:transactions]).where(invoices: {merchant_id: merchant_id}).group(:id).where(transactions: {result: ["success", "failure"]}).select('customers.id')))
  end

  def self.most_successful_transactions(merchant_id)
    Customer.joins(:invoices)
    .joins(invoices: [:transactions])
    .where(transactions: {result: "success"}, invoices: {merchant_id: merchant_id})
    .group(:id)
    .select("customers.id, customers.first_name, customers.last_name, COUNT(transactions) AS successful_transactions")
    .order("successful_transactions DESC").first
  end
end
