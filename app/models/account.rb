class Account < ApplicationRecord
  has_many :transactions

  def balance
    unless self.transactions.length > 0
      return 0
    end
    return self.transactions.map{|t| t.amount}.reduce(:+)
  end
end
