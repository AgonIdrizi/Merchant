class Users::SessionsController < Devise::SessionsController
  before_action :load_default_cart
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |user|
      if user.persisted?
        session[:user_id] = user.id
        #on login, transfer items from previous non-logged-in user session
  		  transfer_order_items_from_previous_session
  		  
      end
    end
  end

  # DELETE /resource/sign_out
   def destroy
   	 
     super
     session[:user_id] = nil
     session[:order_id] = nil
     
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end