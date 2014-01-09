FactoryGirl.define do

  factory :user do

    first_name "Joel"
    last_name "Brewer"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "booyabooya"
    password_confirmation "booyabooya"
    user_type "entrepreneur"
  end

  factory :subscription do |f|
    f.association :user
    f.plan_id '4'
    f.stripe_card_token "Test card token"
    f.stripe_customer_token "Test customer token"
    f.email "joel.brewer@example.com"
  end

  factory :project do
    title "Sample Project"
    user
  end
end
