class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result, :invoice
  belongs_to :invoice

  default_scope { order(:id)}
  scope :success, -> {where(result: "success")}
  # scope :success_and_failure, -> {where(result: ["success", ])}

end