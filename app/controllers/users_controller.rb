class UsersController < ApplicationController
	before_action :authenticate_user!, :load_user, :load_cart
  def profile
  	@orders = user_orders(@user)
  end

  def update
  	if @user.update_attributes(user_params)
  	  flash[:success] = 'User was successfully updated'
  	  redirect_to profile_path
  	else
  	  flash[:danger] = 'Something went wrong, please try again'
  	  redirect_to root_path
  	end
  end

  private
  def load_user
  	@user = current_user
  end
  def user_params
  	params.require(:user).permit(:first_name, :last_name,:default_shiping_address)
  end
end
