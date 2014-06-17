class ChargeFailed
  def call(event)
  end
end

class BillingEventLogger
  def initialize(logger)
    @logger = logger
  end

  def call(event)
    subscription = Subscription.where(:stripe_customer_token => event.customer)
    customer = User.find(subscription.user.id)
    @logger.info "BILLING:#{event.type}:#{event.id}"
    @logger.info "BILLING CUSTOMER:#{customer}"
  end
end

STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
Stripe.api_key    = ENV['STRIPE_API_KEY'] 
StripeEvent.configure do |events|
  events.all BillingEventLogger.new(Rails.logger)
  events.subscribe 'charge.failed', ChargeFailed.new
end

