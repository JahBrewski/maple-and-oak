FactoryGirl.define do

  factory :user do

    first_name "Joel"
    last_name "Brewer"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "booyabooya"
    password_confirmation "booyabooya"
    user_type "entrepreneur"
  end

  factory :plan do

    ignore do
      user :user
    end

    plan_type "entrepreneur"
    plan_level "bronze"
    user_project_limit '1'

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
    title "Sample Project"
    user
  end
end
