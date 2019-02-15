class TransactionsController < ApplicationController

  before_action :authenticate_user!
  def index
    @transactions = Transaction.where user_id: current_user.id
  end

  before_action :authenticate_user!
  def show
    @transaction = Transaction.find_by id: params[:id], user_id: current_user.id
    unless @transaction
      redirect_to transactions_path
    end
  end

  before_action :authenticate_user!
  def new
    @transaction = Transaction.new
  end

  before_action :authenticate_user!
  def edit
    @transaction = Transaction.find_by id: params[:id], user_id: current_user.id
  end

  before_action :authenticate_user!
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction
    else
      render 'new'
    end
  end

  before_action :authenticate_user!
  def update
    @transaction = Transaction.find_by id: params[:id], user_id: current_user.id

    if @transaction.update(transaction_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  before_action :authenticate_user!
  def destroy
    @transaction = Transaction.find_by id: params[:id], user_id: current_user.id
    @transaction.destroy

    redirect_to transactions_path
  end

  private
    def transaction_params
      params[:transaction][:user_id] = current_user.id
      params.require(:transaction).permit(:date, :account_id, :category_id, :amount, :memo, :user_id)
    end
end
