stripe = { app_id: ENV['STRIPE_APP_ID'], secret: ENV['STRIPE_SECRET'] }
STRIPE_PUBLIC_KEY = stripe[:app_id]
Stripe.api_key    = stripe[:secret]
