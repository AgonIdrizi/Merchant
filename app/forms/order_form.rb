class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :status, :shipping_address_id,
  				 :line1, :line2, :city, :state, :zip

  
  validates :line1, :city, :state, :zip, presence: :true  if :shipping_address_id.nil?
  validates :state, format: {with: /[A-Z]{2}/} if :shipping_address_id.nil?
  validates :zip, format: {with: /\d{5}/} if :shipping_address_id.nil?


  	def initialize(params={})
  	  @user_id =  !params[:user_id].nil? ?  params[:user_id] : 0
  	  @shipping_address_id =  !params[:shipping_address_id].nil? ? params[:shipping_address_id] : nil
  	  @status = 'Submited'
  	  @line1 = params[:line1]
  	  @line2 = params[:line2]
  	  @city = params[:city]
  	  @state = params[:state]
  	  @zip = params[:zip]
  	end


  def save
  if valid?
    ActiveRecord::Base.transaction do
    	#debugger
      	
        shipping_address.save! if @shipping_address_id.nil?
        order.save!
      
  	
  	  
    end
    true
  end
  rescue ActiveRecord::StatementInvalid => e
  # Handle database exceptions not covered by validations.
  #e.message and e.cause.message can help you figure out what happened
  
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
    @order = Order.new(status: status,user_id: user_id, shipping_address_id: shipping_address_id)
    end
  end

 


end
