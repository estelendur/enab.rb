class BudgetController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = Account.where(user_id: current_user.id).order(:name) || []
    @categories = Category.where(user_id: current_user.id).order(:due_date, :name) || []
    @transactions = Transaction.where(user_id: current_user.id).order(date: :desc, amount: :asc)
    
    @total_money = @accounts.map{|a| a.balance}.reduce(:+) || 0
    @allocated_money = @categories.map{|c| c.allocation}.reduce(:+) || 0
    @remaining_money = @total_money - @allocated_money
  end
end
