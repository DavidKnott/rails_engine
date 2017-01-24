class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.text :name
      t.text :description
      t.integer :unit_price
      t.references :merchant
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
