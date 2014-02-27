require 'spec_helper'

describe Plan do

  describe "validations" do

    it "has a valid factory" do
      FactoryGirl.create(:plan).should be_valid
    end

    it "is invalid without a plan_type" do
      FactoryGirl.build(:plan, plan_type: nil).should_not be_valid
    end

    it "is invalid without a plan_level" do
      FactoryGirl.build(:plan, plan_level: nil).should_not be_valid
    end

    it "is invalid without a user_profile_limit" do
      FactoryGirl.build(:plan, user_profile_limit: nil).should_not be_valid
    end

    it "is invalid without a user_conversation_limit" do
      FactoryGirl.build(:plan, user_conversation_limit: nil).should_not be_valid
    end
    
    it "is invalid without a price" do
      FactoryGirl.build(:plan, price: nil).should_not be_valid
    end
  end
end
