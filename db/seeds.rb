# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Plan.create(id: "1", plan_level: "bronze", price: "49.00", plan_type: "entrepreneur", description: "Basic investor membership")
Plan.create(id: "2", plan_level: "bronze", price: "69.00", plan_type: "investor", description: "Basic entrepreneur membership")

# read in categories
filepath = "#{Rails.root}/public/categories.txt"
File.open(filepath).each_line do |s|
  ProfileCategory.create(key_name: "#{s.strip.gsub(" ", "_").downcase.singularize}")
end

#create sub categories
ProfileSubCategory.create(key_name: "purchase", description: "Purchase an existing restaurant")
ProfileSubCategory.create(key_name: "startup", description: "Start up restaurant")
ProfileSubCategory.create(key_name: "add_location", description: "Add location(s) to an existing concept")

#add admin(s)
User.create!(first_name: "Meghan", last_name: "Michel", email: "memichel81@gmail.com", username: "memmichel", password: ENV['MEGHAN_ADMIN_PASSWORD'], password_confirmation: ENV['MEGHAN_ADMIN_PASSWORD'], user_type: "entrepreneur", admin: true, active_subscription: true, registered: true)

#create familiarities
Familiarity.create(key_name: "profit_loss", description: "Profit and Loss Statements")
Familiarity.create(key_name: "inventory", description: "Inventory")
Familiarity.create(key_name: "ordering", description: "Ordering")
Familiarity.create(key_name: "foot_costs", description: "Food Costs")
Familiarity.create(key_name: "payroll", description: "Payroll")
Familiarity.create(key_name: "taxes", description: "Taxes")
Familiarity.create(key_name: "workmans_comp", description: "Workmans Compensation")
