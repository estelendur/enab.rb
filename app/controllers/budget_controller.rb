class BudgetController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = Account.where(user_id: current_user.id) || []
    @categories = Category.where(user_id: current_user.id) || []
    
    @total_money = @accounts.map{|a| a.balance}.reduce(:+) || 0
    @allocated_money = @categories.map{|c| c.allocation}.reduce(:+) || 0
    @remaining_money = @total_money - @allocated_money
  end
end
