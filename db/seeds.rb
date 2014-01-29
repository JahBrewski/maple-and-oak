# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Plan.create(id: "1", plan_level: "bronze", price: "15.00", plan_type: "investor", user_project_limit: 0, user_conversation_limit: 5)
Plan.create(id: "2", plan_level: "silver", price: "30.00", plan_type: "investor", user_project_limit: 0, user_conversation_limit: 10)
Plan.create(id: "3", plan_level: "gold"  , price: "40.00", plan_type: "investor", user_project_limit: 0, user_conversation_limit: 15)
Plan.create(id: "4", plan_level: "bronze", price: "15.00", plan_type: "entrepreneur", user_project_limit: 1, user_conversation_limit: 5)
Plan.create(id: "5", plan_level: "silver", price: "30.00", plan_type: "entrepreneur", user_project_limit: 2, user_conversation_limit: 10)
Plan.create(id: "6", plan_level: "gold"  , price: "40.00", plan_type: "entrepreneur", user_project_limit: 3, user_conversation_limit: 15)
