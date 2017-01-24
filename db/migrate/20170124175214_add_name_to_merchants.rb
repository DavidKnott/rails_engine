class AddNameToMerchants < ActiveRecord::Migration[5.0]
  enable_extension "citext"
  def change
    add_column :merchants, :name, :citext
  end
end
