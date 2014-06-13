require 'spec_helper'

describe User, 'validations' do

  it "has a valid factory" do
    FactoryGirl.create(:user, :entrepreneur).should be_valid
  end

  it "should respond to admin" do
    user = FactoryGirl.create(:user, :entrepreneur)
    user.should respond_to(:admin)
  end

  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is invalid without a unique username" do
    FactoryGirl.create(:user, :entrepreneur, username: "test")
    FactoryGirl.build(:user, :entrepreneur, username: "test").should_not be_valid
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
