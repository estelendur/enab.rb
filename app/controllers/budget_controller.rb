class BudgetController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = Account.where(user_id: current_user.id).order(on_budget: :desc, name: :desc) || []
    @categories = Category.where(user_id: current_user.id).order(:due_date, :name) || []
    @transactions = Transaction.where(user_id: current_user.id).order(date: :desc, amount: :asc)
    
    @total_money = @accounts.map{|a| if a.on_budget then a.balance else 0 end}.reduce(:+) || 0
    @allocated_money = @categories.map{|c| c.allocation || 0}.reduce(:+) || 0
    @remaining_money = @total_money - @allocated_money
  end
end
