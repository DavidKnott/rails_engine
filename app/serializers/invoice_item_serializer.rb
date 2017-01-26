class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price
    cents_to_dollars(object.unit_price)
  end

  def cents_to_dollars(cents)
    '%.2f' % (cents/100.0)
  end

end
