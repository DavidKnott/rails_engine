class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    cents_to_dollars(object)
  end

  def cents_to_dollars(cents)
    '%.2f' % (cents/100.0)
  end
end
