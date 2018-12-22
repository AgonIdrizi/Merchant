class OrdersController < ApplicationController
	before_action :set_order_id ,only: [:show, :destroy]
	def show
	 
	end

	def destroy
	  @order.destroy

	  respond_to do |format|
	  	format.html { redirect_to root_path }
	  	format.json { head :no_content }
	  end
	end

	private
	def set_order_id
	  @order = Order.find_by(id: params[:id])
	end
end
