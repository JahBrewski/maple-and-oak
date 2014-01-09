require 'spec_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }

  subject { user } 

  it { should respond_to(:user_type) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  it "should have one subscription" do
    t = User.reflect_on_association(:subscription)
    t.macro.should == :has_one
  end

  describe "when user type is not present" do 
    before { user.user_type = " " }
    it { should_not be_valid }
  end
end

