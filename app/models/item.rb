class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id)}

  def self.most_revenue(top_x)
    joins(:invoice_items)
    	.joins(invoices: [:transactions])
    	.where(transactions: {result: "success"})
    .group("items.id")
    .order("SUM(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(top_x)
  end
end
