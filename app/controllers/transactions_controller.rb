# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @transactions = Transaction.for_user(current_user.id)
  end

  before_action :authenticate_user!
  def show
    @transaction = Transaction.find_by id: params[:id], user_id: current_user.id
    redirect_to transactions_path unless @transaction
  end

  before_action :authenticate_user!
  def new
    @transaction = Transaction.new
    @transaction.date = Date.today
  end

  before_action :authenticate_user!
  def edit
    @transaction = Transaction.find_by id: params[:id],
                                       user_id: current_user.id
  end

  before_action :authenticate_user!
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      if @transaction.expense
        category = @transaction.category
        category.allocation = category.allocation - @transaction.amount
        category.allocation = [0, category.allocation].max
        unless category.save
          flash[:error] = "Unable to update category allocation"
        end
      end
      redirect_to @transaction
    else
      render 'new'
    end
  end

  before_action :authenticate_user!
  def update
    @transaction = Transaction.find_by id: params[:id],
                                       user_id: current_user.id
    old_amount = @transaction.amount

    if @transaction.update(transaction_params)
      if @transaction.expense
        category = @transaction.category
        category.allocation = category.allocation + (old_amount - @transaction.amount)
        category.allocation = [0, category.allocation].max
        unless category.save
          flash[:error] = "Unable to update category allocation"
        end
      end
      redirect_to @transaction
    else
      render 'edit'
    end
  end

  before_action :authenticate_user!
  def destroy
    @transaction = Transaction.find_by(id: params[:id],
                                       user_id: current_user.id)

    @transaction.destroy

    redirect_to transactions_path
  end

  private

  def transaction_params
    params[:transaction][:user_id] = current_user.id
    params.require(:transaction)
          .permit(:date, :account_id, :category_id, :amount, :memo, :user_id,
                  :expense, :cleared)
  end
end
