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

  describe "#publish" do
    let!(:project) { FactoryGirl.create(:project, user: user) }
    it 'sets the publish attribute to true' do
      project.publish
      project.reload
      project.published.should == true
    end
  end

  describe "#unpublish" do
    it 'sets the publish attribute to false' do
      project = FactoryGirl.create(:project, user: user)
      project.unpublish
      project.reload
      project.published.should == false
    end
  end


  describe "#ready_to_publish?" do
    it 'returns false if the project has not been approved' do
      FactoryGirl.build(:project, user: user, status: "not_approved").ready_to_publish?.should == false
    end

    [:city, :state, :company_name, :email_address, :phone_number, :description, :category, :sub_category].each do |attribute|
      it "returns false if the project is missing #{attribute}" do
        FactoryGirl.build(:project, user: user, :"#{attribute}" => nil).should_not be_ready_to_publish
      end
    end

    it 'returns true if the project is not missing requisite fields and project is approved' do
      FactoryGirl.build(:project, user: user).ready_to_publish?.should == true
    end
  end
end

