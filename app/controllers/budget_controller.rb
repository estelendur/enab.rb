class BudgetController < ApplicationController
  def index
    @accounts = Account.all
    @categories = Category.all
    
    @total_money = @accounts.map{|a| a.balance}.reduce(:+)
    @allocated_money = @categories.map{|c| c.allocation}.reduce(:+)
    @remaining_money = @total_money - @allocated_money
  end
end
