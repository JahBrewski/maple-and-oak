FactoryGirl.define do

  sequence(:email)    { |n| "email#{n}@factory.com" }
  sequence(:username) { |n| "person#{n}" }

  factory :user do

    first_name "Joel"
    last_name "Brewer"
    email
    password "booyabooya"
    password_confirmation "booyabooya"
    user_type "entrepreneur"
    username
    admin false
  end

  factory :plan do

    ignore do
      user :user
    end

    plan_type "entrepreneur"
    plan_level "bronze"
    user_project_limit '1'
    user_conversation_limit '5'
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
  end

  factory :project do
    association :user
    company_name "Sample Project"
    city "Nashville"
    state "TN"
    contact_name "Jay Z"
    email_address "jay@z.com"
    phone_number "123-456-7890"
    description "Best project ever"
    category "clothing store"
    sub_category "record studio"
    status "approved"
  end

  factory :conversation do
    subject "test subject"
    recipients "testrecipient@gmail.com"
    body "test body"
  end
end
