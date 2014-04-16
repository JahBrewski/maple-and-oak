require 'spec_helper'

describe Profile do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }

  it "has a valid factory" do
    FactoryGirl.create(:profile, user: user). should be_valid
  end

  describe "#location_state_city" do
    let(:profile) { FactoryGirl.build(:profile, user: user, state: "TN", city: "Nashville") }
    it 'returns the state and city of the profile' do
      profile.location_state_city.should == "Nashville, TN"
    end
  end

  describe "#publish" do
    let!(:profile) { FactoryGirl.create(:profile, user: user) }
    it 'sets the publish attribute to true' do
      profile.publish
      profile.reload
      profile.published.should == true
    end
  end

  describe "#unpublish" do
    it 'sets the publish attribute to false' do
      profile = FactoryGirl.create(:profile, user: user)
      profile.unpublish
      profile.reload
      profile.published.should == false
    end
  end


  describe "#ready_to_publish?" do
    it 'returns false if the profile has not been approved' do
      FactoryGirl.build(:profile, user: user, status: "not_approved").ready_to_publish?.should == false
    end

    [:city, :state, :company_name, :email_address, :phone_number, :description, :category, :sub_category].each do |attribute|
      it "returns false if the profile is missing #{attribute}" do
        FactoryGirl.build(:profile, user: user, :"#{attribute}" => nil).should_not be_ready_to_publish
      end
    end

    it 'returns true if the profile is not missing requisite fields and profile is approved' do
      FactoryGirl.build(:profile, user: user).ready_to_publish?.should == true
    end
  end
end

