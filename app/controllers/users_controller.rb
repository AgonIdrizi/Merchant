class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :load_user
  def profile
  	@orders = @user.orders.present? ? @user.orders : 'There seems not to be any order here' 
  end

  private
  def load_user
  	@user = current_user
  end
end
