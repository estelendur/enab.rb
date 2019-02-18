# frozen_string_literal: true

class AddExpenseToggleToTransactions < ActiveRecord::Migration[5.2]
  def up
    add_column :transactions, :expense, :boolean, default: true
    Transaction.connection.execute('UPDATE transactions SET expense = false
                                   WHERE amount >= 0')
    Transaction.connection.execute('UPDATE transactions SET expense = true,
                                   amount = -amount WHERE amount < 0')
  end

  def down
    Transaction.connection.execute('UPDATE transactions SET amount = 0 - amount
                                   WHERE expense = true')
    remove_column :transactions, :expense
  end
end
