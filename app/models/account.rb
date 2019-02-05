class Account < ApplicationRecord
  has_many :transactions

  def balance
    return self.transactions.map{|t| t.amount}.reduce(:+)
  end
end
