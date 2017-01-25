class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    cents_to_dollars(object.unit_price)
  end

  def cents_to_dollars(cents)
    '%.2f' % (cents/100.0)
  end
end
