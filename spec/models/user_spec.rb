require 'spec_helper'

describe User, 'validations' do

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is invalid without a unique username" do
    FactoryGirl.create(:user, username: "test")
    FactoryGirl.build(:user, username: "test").should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without a usertype" do
    FactoryGirl.build(:user, user_type: nil).should_not be_valid
  end

  it "returns a user's full name as a string" do
    user = FactoryGirl.build(:user, first_name: "Tanya", last_name: "Brewer")
    user.full_name.should == "Tanya Brewer"
  end
  
  it "should have one subscription" do
    t = User.reflect_on_association(:subscription)
    t.macro.should == :has_one
  end
end

describe User, '#conversations_remaining' do
  it 'returns the number of conversations available for the user to initiate' do
    #setup
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    FactoryGirl.create(:plan_with_subscription, :user => user, :user_conversation_limit => 5)
    user.initiate_conversation(other_user, "hello", "world")
    user.conversation_initiations_remaining.should == 4
  end
end
