class Invoice < ApplicationRecord
  validates :customer, presence: true
  validates :status, presence: true

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
end
