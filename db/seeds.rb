# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Plan.create(id: "1", plan_level: "bronze", price: "49.00", plan_type: "investor", user_project_limit: 0, user_conversation_limit: 5, description: "Contact up to 3 members per day. Send a message to any Maple and Oak member.")
Plan.create(id: "2", plan_level: "silver", price: "69.00", plan_type: "investor", user_project_limit: 0, user_conversation_limit: 10, description: "Premium messages: messages are highlighed in the inbox. Contact up to 10 members per day. Send a message to any Mample and Oak member.")
Plan.create(id: "3", plan_level: "gold"  , price: "99.00", plan_type: "investor", user_project_limit: 0, user_conversation_limit: 15, description: "Priority messages: messages appear at the top of people's inbox. Contact the maximum number of 30 members per day. Send a message to any Maple and Oak member.")
Plan.create(id: "4", plan_level: "bronze", price: "49.00", plan_type: "entrepreneur", user_project_limit: 1, user_conversation_limit: 5, description: "Contact up to 3 members per day. Send a message to any Maple and Oak member.")
Plan.create(id: "5", plan_level: "silver", price: "69.00", plan_type: "entrepreneur", user_project_limit: 2, user_conversation_limit: 10, description: "Premium messages: messages are highlighed in the inbox. Contact up to 10 members per day. Send a message to any Mample and Oak member.")
Plan.create(id: "6", plan_level: "gold"  , price: "99.00", plan_type: "entrepreneur", user_project_limit: 3, user_conversation_limit: 15, description: "Expedited approval for business plan. Priority messages: messages appear at the top of people's inbox. Contact the maximum number of 30 members per day. Send a message to any Maple and Oak member.")

# read in categories
filepath = "#{Rails.root}/public/categories.txt"
File.open(filepath).each_line do |s|
  ProjectCategory.create(key_name: "#{s.strip.gsub(" ", "_").downcase.singularize}")
end

#create sub categories
ProjectSubCategory.create(key_name: "purchase", description: "Purchase an existing restaurant")
ProjectSubCategory.create(key_name: "startup", description: "Start up restaurant")
ProjectSubCategory.create(key_name: "add_location", description: "Add location(s) to an existing concept")

#add admin(s)
User.create!(first_name: "Meghan", last_name: "Michel", email: "memichel81@gmail.com", username: "memmichel", password: "#{ENV['MEGHAN_ADMIN_PASSWORD']}", password_confirmation: "#{ENV['MEGHAN_ADMIN_PASSWORD']", user_type: "entrepreneur", admin: true, active_subscription: true)
