# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :transactions

  def last_30_days
    return 0 if name.casecmp('initial balance').zero?

    transactions = Transaction.where 'category_id = ? AND created_at > ?',
                                     id, (Date.today - 30)
    return 0 if transactions.empty?

    transactions
      .map { |t| t.expense ? t.amount : -t.amount }
      .reduce(:+)
  end
end
