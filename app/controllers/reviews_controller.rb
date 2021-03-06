class ReviewsController < ApplicationController
  #might only need index show delete
  def index #show all
    #@review = Review.where(product_id: params[:product_id]).first

  end

  def show # show one all display a view that has already been created
      @review = Review.all.where(params[:product_id])
      render :new
  end

  def new
      @review = Review.new
      @product = Product.find(params[:product_id])
      render :new
  end

  def create
    @reviewparams = review_params
    @review = Review.new(review_params)
    if  @review.save
      redirect_to product_path(@review.product_id)
    else 
      @review = Review.new
      @product = Product.find(params[:product_id])
      render :new
    end

  end

  def edit
    @review = Reviews.find(params[:id])
    render :new
  end

  def update
  end

  def delete
  end
end


private

  def review_params
    params.require(:review).permit(:review_text, :rating, :product_id)
  end
