class InvoiceItem < ApplicationRecord
  validates :item, presence: true
  validates :invoice, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true

  belongs_to :item
  belongs_to :invoice
end
