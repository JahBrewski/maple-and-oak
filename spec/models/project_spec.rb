require 'spec_helper'

describe Project do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }

  it "has a valid factory" do
    FactoryGirl.create(:project, user: user). should be_valid
  end

  describe "#location_state_city" do
    let(:project) { FactoryGirl.build(:project, user: user, state: "TN", city: "Nashville") }
    it 'returns the state and city of the project' do
      project.location_state_city.should == "Nashville, TN"
    end
  end

  describe "#ready_to_publish?" do
    it 'returns false if the project has not been approved' do
      FactoryGirl.build(:project, user: user, status: "not_approved").ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a city' do
      FactoryGirl.build(:project, user: user, city: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a state' do
      FactoryGirl.build(:project, user: user, state: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a company_name' do
      FactoryGirl.build(:project, user: user, company_name: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing an email_address' do
      FactoryGirl.build(:project, user: user, email_address: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a phone_number' do
      FactoryGirl.build(:project, user: user, phone_number: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a description' do
      FactoryGirl.build(:project, user: user, description: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a category' do
      FactoryGirl.build(:project, user: user, category: nil).ready_to_publish?.should == false
    end

    it 'returns false if the project is missing a sub_category' do
      FactoryGirl.build(:project, user: user, sub_category: nil).ready_to_publish?.should == false
    end

    it 'returns true if the project is not missing requisite fields and project is approved' do
      FactoryGirl.build(:project, user: user).ready_to_publish?.should == true
    end
  end
end

