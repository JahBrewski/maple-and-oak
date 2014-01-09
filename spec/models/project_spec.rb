require 'spec_helper'

describe Project do
  #let(:user) { FactoryGirl.create(:user, subscription_args: { plan_id: '4', email: user.email, stripe_card_token: card, user: user, user_id: user.id }) }

  let(:user) { FactoryGirl.create(:user) }

  let(:card) do 
    { :number => '4242424242424242', :exp_month => '11', :exp_year => '2020' }
  end

  let(:plan) { Plan.where(:plan_type => user.user_type).sample }
  let(:project) { user.projects.build(title: "New Project") }

  subject { project }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  describe "Adding a new project" do

    it "should add a new project" do
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
