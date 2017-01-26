class ChangeItemsNameAndDescToCiText < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :name
    remove_column :items, :description
    add_column :items, :name, :citext
    add_column :items, :description, :citext
  end
end
