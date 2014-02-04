require 'spec_helper'

describe Project do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }

  it "has a valid factory" do
    FactoryGirl.create(:project, user: user). should be_valid
  end

  it "is invalid without a description" do
    FactoryGirl.build(:project, user: user, description: nil).should_not be_valid
  end

  it "is invalid without a state" do
    FactoryGirl.build(:project, user: user, state: nil).should_not be_valid
  end

  it "is invalid without a city" do
    FactoryGirl.build(:project, user: user, city: nil).should_not be_valid
  end

  describe "#location_state_city" do
    let(:project) { FactoryGirl.build(:project, user: user, state: "TN", city: "Nashville") }
    it 'returns the state and city of the project' do
      project.location_state_city.should == "Nashville, TN"
    end
  end
end

