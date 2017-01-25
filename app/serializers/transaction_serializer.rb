class TransactionSerializer < ActiveModel::Serializer
  attributes :invoice_id, :credit_card_number, :result
end
