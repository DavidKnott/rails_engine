class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  def self.ci_find(find_params)
    where("lower(#{find_params.keys.first}) =?", find_params.values.first.downcase).first
  end
end

