class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price_pennies
    (object.unit_price * 100).to_i
  end
end
