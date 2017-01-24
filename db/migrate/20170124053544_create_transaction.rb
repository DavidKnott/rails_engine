class CreateTransaction < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer     :credit_card_number
      t.text        :result
      t.datetime    :created_at,   null: false
      t.datetime    :updated_at,   null: false
      t.references  :invoice,      foreign_key: true
    end
  end
end
