class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ci_find(find_params)
    ci_find_all(find_params).first
  end

  def self.ci_find_all(find_params)
    where("lower(#{find_params.keys.first}) =?", find_params.values.first.downcase)
  end
end
