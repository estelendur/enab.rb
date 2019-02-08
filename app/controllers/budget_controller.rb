class BudgetController < ApplicationController
  def index
    @accounts = Account.all
    @categories = Category.all
    
    @total_money = @accounts.map{|a| a.balance || 0}.reduce(:+) || 0
    @allocated_money = @categories.map{|c| c.allocation || 0}.reduce(:+) || 0
    @remaining_money = @total_money - @allocated_money
  end
end
