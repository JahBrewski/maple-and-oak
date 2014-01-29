require 'spec_helper'

describe Project do

  it "has a valid factory" do
    FactoryGirl.create(:project). should be_valid
  end

  it "is invalid without a description" do
    FactoryGirl.build(:project, description: nil).should_not be_valid
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:card) do 
    { :number => '4242424242424242', :exp_month => '11', :exp_year => '2020' }
  end
  let(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }

  let(:project) { FactoryGirl.build(:project, :user => user) }

  subject { project }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  describe "Add new project button" do

    it "should add a new project if user has projects remaining" do
      
      expect { project.save }.to change(Project, :count).by(1)
    end

    it "should not add a new project if user does not have projects remaining"
  end
  
  describe "Removing a project" do
    it "should remove the project if the user is correct"
    it "should not remove the project if the user is not correct"
  end
  it { should be_valid }
end
