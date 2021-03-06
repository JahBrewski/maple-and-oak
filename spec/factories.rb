FactoryGirl.define do

  sequence(:email)    { |n| "email#{n}@factory.com" }
  sequence(:username) { |n| "person#{n}" }

  factory :user do
    first_name "Joel"
    last_name "Brewer"
    email
    password "booyabooya"
    password_confirmation "booyabooya"
    username
    admin false
    active_subscription true

    trait :entrepreneur do
      user_type "entrepreneur"
    end

    trait :investor do
      user_type "investor"
    end
  end

  factory :plan do

    ignore do
      user :user
    end

    plan_type "entrepreneur"
    plan_level "bronze"
    price '15'

    factory :plan_with_subscription do
      after(:create) do |plan, evaluator|
        create(:subscription, plan: plan, user: evaluator.user)
      end
    end
  end

  factory :subscription do |f|
    f.association :user
    f.association :plan
    f.stripe_card_token "Test card token"
    f.stripe_customer_token "Test customer token"
    f.email "joel.brewer1@example.com"
    after(:create) do |user, evaluator|
      evaluator.user.update_attribute(:active_subscription, true)
    end
  end

  factory :profile do
    association :user, :entrepreneur
    company_name "Sample Profile"
    city "Nashville"
    state "TN"
    contact_name "Jay Z"
    contact_email_address "jay@z.com"
    contact_phone_number "123-456-7890"
    short_description "Best profile ever"
    long_description "Best profile ever. Best profile ever."
    category "clothing store"
    sub_category "record studio"
    status "approved"
    published false

    trait :investor do
      investment_amount "100"
      seat_number "100"
    end
  end

  factory :conversation do
    subject "test subject"
    recipients "testrecipient@gmail.com"
    body "test body"
  end
end
