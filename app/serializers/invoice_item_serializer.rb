class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :item_id, :invoice_id, :quantity, :unit_price
end
