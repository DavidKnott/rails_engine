class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(number_of_items)
    Item.joins(:invoice_items, :invoices).
    joins(invoices: [:transactions]).
    where(transactions: {result:"success"}).
    group(:id).
    select("items.id, items.name, items.description, items.unit_price, items.merchant_id, SUM(invoice_items.quantity) as quant").order("quant desc").limit(number_of_items)
  end
  
  def self.most_revenue(top_x)
    Item.joins(:invoice_items, :invoices)
    .joins(invoices: [:transactions])
      .where(transactions: {result: "success"})
    .group(:id)
    .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .reorder('total_revenue DESC')
    .limit(top_x)
  end
end
