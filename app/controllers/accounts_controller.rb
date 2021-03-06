# frozen_string_literal: true

# TODO: deal with rubocop AbcSize properly
# (https://stackoverflow.com/questions/30932732/
# what-is-meant-by-assignment-branch-condition-size-too-high-and-how-to-fix-it)

class AccountsController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = Account.where user_id: current_user.id
    @accounts ||= []
  end

  before_action :authenticate_user!
  def show
    @account = Account.find_by id: params[:id], user_id: current_user.id
    redirect_to accounts_path unless @account
    @transaction = Transaction.new
    @transaction.account_id = params[:id]
    @transaction.date = Date.today
    @transactions = Transaction.for_account params[:id], current_user.id
  end

  before_action :authenticate_user!
  def new
    @account = Account.new
  end

  before_action :authenticate_user!
  def edit
    @account = Account.find_by id: params[:id], user_id: current_user.id
  end

  before_action :authenticate_user!
  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to @account
    else
      render 'new'
    end
  end

  before_action :authenticate_user!
  def update
    @account = Account.find_by id: params[:id], user_id: current_user.id

    if @account.update(account_params)
      redirect_to @account
    else
      render 'edit'
    end
  end

  before_action :authenticate_user!
  def destroy
    @account = Account.find_by id: params[:id], user_id: current_user.id
    @account.destroy

    redirect_to accounts_path
  end

  private

  def account_params
    params[:account][:user_id] = current_user.id
    params.require(:account).permit(:name, :user_id, :on_budget)
  end
end
