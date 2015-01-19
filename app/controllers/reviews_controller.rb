class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  after_action :update_chef_rating, only: [:create, :update, :destroy]

  authorize_resource

  respond_to :html

  def new
    @review = Review.new
    @review.order_id = params[:order_id]
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Review created."
      respond_with(@review.order)
    else
      render :new
    end
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "Review updated."
      respond_with(@review.order)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "Review deleted."
    respond_with(@review.order)
  end

  private
  def set_review
    @review = Review.find(params[:id])
  end

  def update_chef_rating
    @user = @review.order.meal.user
    @user.set_rating
  end

  private
  def review_params
    params.require(:review).permit(:order_id, :rating, :review)
  end

end
