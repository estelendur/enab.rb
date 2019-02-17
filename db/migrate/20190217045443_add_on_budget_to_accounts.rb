class AddOnBudgetToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :on_budget, :boolean, default: true
  end
end
