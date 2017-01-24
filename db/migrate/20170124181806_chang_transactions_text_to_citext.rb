class ChangTransactionsTextToCitext < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :result
    add_column :transactions, :result, :citext
  end
end
