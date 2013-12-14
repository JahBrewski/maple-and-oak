# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    price 1
    plan_type "MyString"
    plan_level "MyString"
    user_project_limit 1
  end
end
