class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.pending_invoices(merchant_id)
    Customer.joins(:invoices, :transactions).where(invoices: {merchant_id: merchant_id}).group(:id).where('customers.id NOT IN (?)', (Customer.joins(:invoices).joins(invoices: [:transactions]).where(invoices: {merchant_id: merchant_id}).group(:id).where(transactions: {result: ["success"]}).select('customers.id')))
  end
end