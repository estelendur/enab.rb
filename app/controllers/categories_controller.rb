class CategoriesController < ApplicationController

  before_action :authenticate_user!
  def index
    @categories = Category.where(user_id: current_user.id).order(:due_date, :name) || []
  end

  before_action :authenticate_user!
  def show
    @category = Category.find_by id: params[:id], user_id: current_user.id
    unless @category
      redirect_to categories_path
    end
    @transaction = Transaction.new
    @transaction.category_id = params[:id]
    @transactions = Transaction.where category_id: params[:id], user_id: current_user.id
  end

  before_action :authenticate_user!
  def new
    @category = Category.new
  end

  before_action :authenticate_user!
  def edit
    @category = Category.find_by id: params[:id], user_id: current_user.id
  end

  before_action :authenticate_user!
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  before_action :authenticate_user!
  def update
    @category = Category.find_by id: params[:id], user_id: current_user.id

    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  before_action :authenticate_user!
  def destroy
    @category = Category.find_by id: params[:id], user_id: current_user.id
    @category.destroy

    redirect_to categories_path
  end

  private
    def category_params
      params[:category][:user_id] = current_user.id
      params.require(:category).permit(:name, :allocation, :goal_amount, :due_date, :user_id)
    end
end
