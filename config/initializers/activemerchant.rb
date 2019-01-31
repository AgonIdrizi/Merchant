if Rails.env == "development"
  ActiveMerchant::Billing::SecurionPayGateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::SecurionPayGateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  
  secret_key = ENV['SECURION_PAY_GATEWAY_SECRET']

elsif Rails.env == "production"

  
  secret_key = ENV['SECURION_PAY_GATEWAY_SECRET']
end
GATEWAY = ActiveMerchant::Billing::SecurionPayGateway.new({
      secret_key: ENV['SECURION_PAY_GATEWAY_SECRET']
})