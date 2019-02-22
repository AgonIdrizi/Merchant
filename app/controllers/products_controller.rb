class ProductsController < ApplicationController
  before_action :load_cart
  before_action :check_if_admin , only: [:create, :new, :update, :edit, :destroy]
  def index
    @products = Product.all
  end

  def show
    #we must check if product exits before showing a product
    if Product.find_by(id: params[:id]).present?
      @product = Product.find_by(id: params[:id]) 
    else
      redirect_to root_path
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success]= "Record was created"
      redirect_to root_path
    else
      flash.now[:danger]= "There was an error creating the product, please try once more"
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :description, :image)
  end

  def check_if_admin
    if !current_user.try(:admin?)
      flash[:danger] = "You dont have permission"
      redirect_to root_path
    end
  end
end
