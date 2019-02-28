# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :transactions

  def balance
    return 0 if transactions.empty?

    transactions
      .map { |t| t.expense ? -t.amount : t.amount }
      .reduce(:+)
  end

  def cleared_balance
    return 0 if transactions.empty?

    transactions
      .filter { |t| t.cleared }
      .map { |t| t.expense ? -t.amount : t.amount }
      .reduce(:+)
  end
end
