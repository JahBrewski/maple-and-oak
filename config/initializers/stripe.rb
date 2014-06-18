class ChargeFailed
  def call(event)
    subscription = Subscription.where(:stripe_customer_token => event.data.object.card.customer)
    customer = User.find(subscription[0].user.id)
    customer.update_attribute(:active_subscription, false)
  end
end

STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
Stripe.api_key    = ENV['STRIPE_API_KEY'] 
StripeEvent.configure do |events|
  events.subscribe 'charge.failed', ChargeFailed.new
end
