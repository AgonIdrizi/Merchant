class Charge < ActiveRecord::Base
  require "active_merchant/billing/rails"

  attr_accessor :card_security_code
  attr_accessor :credit_card_number
  attr_accessor :expiration_month
  attr_accessor :expiration_year

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_security_code, presence: true
  validates :cvc, presence: true
  validates :mm, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :yy, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def credit_card 
  	ActiveMerchant::Billing::CreditCard.new(
      first_name:          'Bob',
      last_name:           'Bobsen',
      number:              credit_card_number,
      month:               mm,
      year:                yy,
      verification_value:  cvc)
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
      response = GATEWAY.authorize(amount , credit_card)
      if response.success?
        transaction = GATEWAY.capture(amount , response.authorization)
        if !transaction.success?
          errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
          false
        end
        update_columns({authorization_code: transaction.authorization, success: true})
        true
      else
        errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
        false
      end
    end
  end

end