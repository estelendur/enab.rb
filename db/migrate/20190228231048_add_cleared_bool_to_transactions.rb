# frozen_string_literal: true

class AddClearedBoolToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :cleared, :boolean, default: false
  end
end
