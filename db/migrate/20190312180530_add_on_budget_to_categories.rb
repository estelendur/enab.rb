class AddOnBudgetToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :on_budget, :boolean, default: true
  end
end
