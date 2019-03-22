# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :transactions

  def last_30_days
    return 0 unless self.on_budget

    transactions = Transaction.where 'category_id = ? AND created_at > ?',
                                     id, (Date.today - 30)
    return 0 if transactions.empty?

    transactions
      .map { |t| t.expense ? t.amount : 0 }
      .reduce(:+)
  end

  def save_daily
    self.money_left / self.days_until_goal
  end

  def save_weekly
    self.money_left / self.weeks_left
  end

  def save_biweekly
    self.money_left / self.biweeks_left
  end

  def save_semimonthly
    self.money_left / self.semimonths_left
  end

  def save_monthly
    self.money_left / self.months_left
  end

  def days_until_goal
    (self.due_date - Date.today).to_i
  end

  def money_left
    self.goal_amount - self.allocation
  end

  def weeks_left
    self.days_until_goal / 7
  end

  def biweeks_left
    self.days_until_goal / 14
  end

  def semimonths_left
    self.days_until_goal / 15
  end

  def months_left
    self.days_until_goal / 30
  end
end
