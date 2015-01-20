class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  authorize_resource

  respond_to :html

  def index
    @orders = current_user.orders_placed.page(params[:page])
    respond_with(@orders)
  end

  def show
    respond_with(@order)
  end

  def new
    @order = Order.new
    @order.meal_id = params[:meal_id] # possibly inefficient?
    @order.price = @order.meal.price
    respond_with(@order)
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if @order.save
      @meal = Meal.find(@order.meal_id)
      @meal.quantity -= @order.quantity
      @meal.save
      flash[:notice] = "Order created."
      respond_with(@order)
    else
      render :new
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :meal_id, :fetch_at, :price, :quantity, :comments, :credit_card_name, :credit_card_number, :credit_card_expiry)
  end

end
