class AddressesController < ApplicationController
   before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = current_user ? current_user.addresses.new : Address.new
    @order = Order.find(params[:order_id])
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    
    @address = Address.new(address_params)
    #debugger
    
    respond_to do |format|
      if @address.save
        #for not logged in users,we'll keep track of their address through address_id attribute in orders table
        Order.find(session[:order_id]).update_attributes(address_id: @address.id) if current_user.nil?
        format.html { redirect_to order_path(session[:order_id]), notice: 'Address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:line1, :line2, :city, :state, :zip, :user_id)
    end

    #def redirect_after_creating_address
      #if current_user is present redirect to his last unsubmited order_id
      #if session[:order_id] is present redirect to order_path(session[:order_id])
      #if he is creating address from his /profile redirect to his profile
    #end
end
