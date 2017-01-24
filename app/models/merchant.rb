class Merchant < ActiveRecord::Base

  def self.ci_find(find_params)
    where("lower(#{find_params.keys.first}) =?", find_params.values.first.downcase).first
  end

end