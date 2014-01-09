FactoryGirl.define do

  factory :user do


    first_name "Joel"
    last_name "Brewer"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "booyabooya"
    password_confirmation "booyabooya"
    user_type "entrepreneur"

    #subscription { build(:subscription, subscription_args) }

    #after(:create) do |user|
    #  user.subscription.save!
    #end

    #after(:create) do |user|
    #association :subscription
    #  Subscription.new(:plan_id => '4', :email => user.email, :stripe_card_token => valid_card_data, :user => user, :user_id => user.id).save
    #end
    #end
  end

  factory :subscription do
    user
    plan_id '4'
    stripe_card_token valid_card_data
    email "joel.brewer@example.com"
  end

  factory :project do
    title "Sample Project"
    user
  end
end
