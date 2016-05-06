class ProductsController < ApplicationController
  def index
    # right now this generates a list of every product in the products table.
    @products = Product.order(id: :asc)
    render :index
  end

  def show
    # this needs to be amended to hook into the session
    # controller action: if @user_id (show "list" view for user)/if category (show "list" view by category)
    @product = Product.find(params[:id])
    @reviews = Review.where(product_id: @product.id)
    render :product_details
  end

  def show_by_merchant
    @merchant = User.find(params[:user_id])
    @products = Product.where(user_id: @merchant.id)

    render :users_products
  end

  def show_by_category
    @category = Category.find(params[:category_id])
    @products = Product.includes(categories: @category.name)

    render :categories_products
  end

  def new
    # user = curent user here.
    @user = User.find(params[:id])
    @product = Product.new
    render :create_product
  end

  def create
    @cats = product_create_params[:product][:categories]
    raise
    @product = Product.create(product_create_params[:product])
    redirect_to products_show_path(@current_user.id)
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_update_params[:product])
    redirect_to products_show_path(@current_user.id)
  end

  def destroy
   killed_record = Product.destroy(params[:id])
   if params[:id] = true
     redirect_to products_show_path(@current_user.id)
   end
  end

  private
  def product_create_params
    params.permit(product: [:name, :user_id, :price_in_dollars, :categories, :visible, :quantity, :image_url])
  end

  # def product_create_params
  #   params.permit(product: [:item, :user_id])
  # end
end
