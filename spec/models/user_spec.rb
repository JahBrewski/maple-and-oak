require 'spec_helper'

describe User do

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "returns a user's full name as a string" do
    user = FactoryGirl.build(:user, first_name: "Tanya", last_name: "Brewer")
    user.full_name.should == "Tanya Brewer"
  end
  
  let(:user) { FactoryGirl.create(:user) }

  it "should have one subscription" do
    t = User.reflect_on_association(:subscription)
    t.macro.should == :has_one
  end

  describe "when user type is not present" do 
    before { user.user_type = " " }
    it { should_not be_valid }
  end
end

