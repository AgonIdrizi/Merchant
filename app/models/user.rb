class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  has_many :orders
  has_many :addresses
  has_one :default_shipping_address, class_name: 'Address'
  has_one :cart
  
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :default_shipping_address, -> {addresses.where(default_shipping_address: true)}

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      
    end
  end
  
end
