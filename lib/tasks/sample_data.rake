namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    20.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email
      username = first_name + last_name
      password = "foobarfoobar"
      user_type = "entrepreneur"

      u = User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   username: username,
                   password: password,
                   password_confirmation: password,
                   user_type: user_type)
      Subscription.create!(plan_id: 4, user_id: u.id, stripe_customer_token: u.id)

    end
    
    users = User.all(limit: 20)
    users.each do |u|
      state = Faker::Address.state_abbr
      city = Faker::Address.city
      title = Faker::Company.name
      contact_name = Faker::Name.name
      email_address = Faker::Internet.email
      phone_number = Faker::PhoneNumber.phone_number
      description = Faker::Company.catch_phrase
      category = ProjectCategory.random.key_name
      sub_category = ProjectSubCategory.random.key_name

      u.projects.create!(title: title,
                        city: city,
                        state: state,
                        contact_name: contact_name,
                        email_address: email_address,
                        phone_number: phone_number,
                        description: description,
                        category: category,
                        sub_category: sub_category)
    end
  end
end
