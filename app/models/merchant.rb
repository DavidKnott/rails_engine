class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  def self.ci_find(find_params)
    ci_find_all(find_params).first
  end

  def self.ci_find_all(find_params)
    where("lower(#{find_params.keys.first}) =?", find_params.values.first.downcase)
  end
end

