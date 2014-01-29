require 'spec_helper'

describe 'Subscriptions' do

  let(:user) { FactoryGirl.create(:user) }
  
  subject { page }

  before do
    @plan = Plan.create(id: "1", plan_level: "bronze", price: "15:00", plan_type: "entrepreneur")
    sign_in user
  end

  describe 'signing up' do
    
    before do 
      visit plans_path
    end

    it "should have a link to the plan" do
      
      should have_content(@plan.name)
    
    end
  end
end
