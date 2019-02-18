# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.date :date
      t.references :account, foreign_key: true
      t.references :category, foreign_key: true
      t.decimal :amount
      t.string :memo

      t.timestamps
    end
  end
end
