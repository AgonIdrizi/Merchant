class CartsController < ApplicationController
  before_action :set_cart_id ,only: [:show, :edit, :update, :destroy, :confirm]
  #before_action :load_cart, only: [:create, :update] 
 
  before_action :access_only_your_cart




  def show
    @session = session[:cart_id]
  end
  def create
	  @cart = Cart.new(cart_params)

      respond_to do |format|
        if @cart.save
          session[:cart_id] = @cart.id
          format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
          format.json { render action: 'show', status: :created, location: @cart }
        else
          format.html { render action: 'new' }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end
    def update
      respond_to do |format|
        if @cart.update(cart_params.merge(status: 'submitted'))
          format.html { redirect_to confirm_order_path(@order), notice: 'Cart was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
	  @cart.destroy
    session[:cart_id] = nil
	  respond_to do |format|
	  	format.html { redirect_to root_path }
	  	format.json { head :no_content }
	  end
	end

    private
    def cart_params
      params.require(:cart).permit(:user_id)
    end

    def set_cart_id
	  @cart = Cart.find_by(id: session[:cart_id])
    #debugger
	end

    #dont allow users to acccess other orders, by checking the id of order in the session[:order_id] and by checking param[:id] of URI to which user is navigating
  def access_only_your_cart
    #debugger
    if params[:id].to_i  != session[:cart_id]
      redirect_to root_path
    end
  end
end
