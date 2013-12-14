FactoryGirl.define do
  factory :user do
    first_name "Joel"
    last_name "Brewer"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "booyabooya"
    password_confirmation "booyabooya"
    user_type "entrepreneur"
  end
end

