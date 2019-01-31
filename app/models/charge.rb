class Charge < ApplicationRecord
  require "active_merchant/billing/rails"
  belongs_to :order, optional:true
  attr_accessor :card_security_code
  attr_accessor :credit_card_number
  attr_accessor :expiration_month
  attr_accessor :expiration_year

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_security_code, presence: true
  validates :credit_card_number, presence: true
  validates :expiration_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :expiration_year, presence: true
  

  def credit_card 
  	ActiveMerchant::Billing::CreditCard.new(
      first_name:          first_name,
      last_name:           last_name,
      number:              credit_card_number.to_i,
      month:               expiration_month.to_i,
      year:                expiration_year.to_i,
      verification_value:  card_security_code.to_i)
  end

  def valid_card
    if !credit_card.valid?
      errors.add(:base, "The credit card information you provided is not valid.  Please double check the information you provided and then try again.")
      false
    else
      true
    end
  end

  def process
    if valid_card
        transaction = GATEWAY.purchase(10000 , credit_card)
        if !transaction.success?
          errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return false
        end
        update_columns({authorization_code: transaction.authorization,last4: transaction.params["card"]["last4"], success: true})
        true
      
    end
  end
end
