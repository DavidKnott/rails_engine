class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id)}

  def self.most_items(number_of_items)
    Item.unscoped.joins(:invoice_items, :invoices).
    joins(invoices: [:transactions]).
    where(transactions: {result:"success"}).
    group(:id).
    select("items.id, items.name, items.description, items.unit_price, items.merchant_id, SUM(invoice_items.quantity) as quant").order("quant desc").limit(number_of_items)
  end
end
