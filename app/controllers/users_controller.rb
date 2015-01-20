class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  authorize_resource

  respond_to :html

  def show
    @reviews = @user.reviews #.page(params[:page])
    @current_meals = @user.meals.current
    @archived_meals = @user.meals.archived #.page(params[:page])
    @current_orders_received = @user.orders_received.current
    @archived_orders_received = @user.orders_received.archived #.page(params[:page])
    respond_with(@user)
  end

  def edit
  end

  def update
    @user.role = "chef"
    if @user.update(user_params)
      flash[:notice] = "Chef profile updated."
      respond_with(@user)
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :chef_name, :description, :phone_number, :address_line_1, :address_line_2, :city, :postcode, :country, :image, :remote_image_url)
  end

end
