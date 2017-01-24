class DropNameFromMerchants < ActiveRecord::Migration[5.0]
  def change
    remove_column :merchants, :name, :text
  end
end
