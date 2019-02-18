class MakeDependentTablesDestroy < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :accounts, :users
    add_foreign_key :accounts, :users, on_delete: :cascade

    remove_foreign_key :categories, :users
    add_foreign_key :categories, :users, on_delete: :cascade

    remove_foreign_key :transactions, :users
    add_foreign_key :transactions, :users, on_delete: :cascade

    remove_foreign_key :transactions, :accounts
    add_foreign_key :transactions, :accounts, on_delete: :cascade

    remove_foreign_key :transactions, :categories
    add_foreign_key :transactions, :categories, on_delete: :cascade
  end
end
