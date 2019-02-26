# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category

  def self.for_category(id, user_id)
    where category_id: id, user_id: user_id
    order(date: :desc, amount: :asc)
  end

  def self.for_account(id, user_id)
    where account_id: id, user_id: user_id
    order(date: :desc, amount: :asc)
  end

  def self.for_user(user_id)
    where user_id: user_id
    order(date: :desc, amount: :asc)
  end

end
