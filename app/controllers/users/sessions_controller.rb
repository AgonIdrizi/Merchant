class Users::SessionsController < Devise::SessionsController
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
  		load_order
  		@order.update_attributes(user: user)
      end
    end
  end

  # DELETE /resource/sign_out
   def destroy
   	 session[:user_id] = nil
  	 session[:order_id] = nil
     super
     
     
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end