require 'spec_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  let(:card) do 
    { :number => '4242424242424242', :exp_month => '11', :exp_year => '2020' }
  end
  let(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }

  let(:project) { FactoryGirl.build(:project, :user => user) }

  #before do
  #  FactoryGirl.create(:subscription, :stripe_card_token => card, :user => user, :plan_id => plan.id)
  #end

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
