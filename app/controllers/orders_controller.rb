class OrdersController < ApplicationController
	before_action :set_order_id ,only: [:show, :edit, :update, :destroy, :confirm]
	def show
	 
	end
	def new
	  @order = Order.new
	end
	def create
	  @order = Order.new(order_params)

      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render action: 'show', status: :created, location: @order }
        else
          format.html { render action: 'new' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end
    def update
      respond_to do |format|
        if @order.update(order_params.merge(status: 'submitted'))
          format.html { redirect_to confirm_order_path(@order), notice: 'Order was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    def confirm
    end
	

	def destroy
	  @order.destroy

	  respond_to do |format|
	  	format.html { redirect_to root_path }
	  	format.json { head :no_content }
	  end
	end

	private

	def order_params
      params.require(:order).permit(:user_id, :status, :address_id)
    end

	def set_order_id
	  @order = Order.find_by(id: params[:id])
	end
end