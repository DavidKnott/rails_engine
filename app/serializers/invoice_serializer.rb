class InvoiceSerializer < ActiveModel::Serializer
  attributes :customer_id, :id, :status, :merchant_id
end