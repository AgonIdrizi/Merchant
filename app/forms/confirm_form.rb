class ConfirmForm
  include ActiveModel::Model

  attr_accessor :user_id, :status, :shipping_address_id,
  				      :line1, :line2, :city, :state, :zip,
  				      :email,
  				      :cart
               attr_reader :order
  
  validates :email, presence: true
  validates :line1, :city, :state, :zip, presence: :true  
  validates :state, format: {with: /[A-Z]{2}/} 
  validates :zip, format: {with: /\d{5}/}
  validate :validate_children

  	def initialize(params={}, cart)
  	  @user_id =  !params[:user_id].nil? ?  params[:user_id] : 0
  	  @shipping_address_id =  !params[:shipping_address_id].nil? ? params[:shipping_address_id] : nil
  	  @status = 'needs_payment'
  	  @line1 = params[:line1]
  	  @line2 = params[:line2]
  	  @city = params[:city]
  	  @state = params[:state]
  	  @zip = params[:zip]
  	  @cart = cart
  	  @email = params[:email]
      @order = order
  	end


  def save

  if valid?
    ActiveRecord::Base.transaction do
      shipping_address.save! if @shipping_address_id.nil?
      @order.save!
      raise ActiveRecord::Rollback if order.id == nil
      update_line_items(order) 
    end
    true
  else 
    false
  end
  
  end

  def shipping_address
  	@shiping_address = order.build_shipping_address(
  	  line1: line1,
  	  line2: line2,
  	  city: city,
  	  state: state,
  	  zip: zip
  	  )
  end

  def order
  	
  	if @shipping_address_id.nil?
  	@order ||= Order.new(status: status,user_id: user_id)
    else
    @order ||= Order.new(status: status,user_id: user_id, shipping_address_id: shipping_address_id)
    end
  end

  def update_line_items(order)
  	cart.order_items.each do |item|
  	  item.order_id = order.id
  	  item.save!
  	end
  end

  def validate_children
    
    if shipping_address.invalid?
      promote_errors(shipping_address.errors)
    end
  end
  def promote_errors(child_errors)
    child_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end
 


end
