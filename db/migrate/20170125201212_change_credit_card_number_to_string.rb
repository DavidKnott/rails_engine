class ChangeCreditCardNumberToString < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :credit_card_number, :integer
    add_column :transactions, :credit_card_number, :string
  end
end
