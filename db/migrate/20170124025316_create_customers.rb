class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.text :first_name
      t.text :last_name
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
