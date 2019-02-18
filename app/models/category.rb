class Category < ApplicationRecord
  has_many :transactions

  def last_30_days
    if self.name.downcase == 'initial balance'
      return 0
    end
    transactions = Transaction.where "category_id = ? AND created_at > ?", self.id, (Date::today - 30)
    unless transactions.length > 0
      return 0
    end
    return transactions
      .map{|t| if t.expense then t.amount else -t.amount end}
      .reduce(:+)
  end
end
