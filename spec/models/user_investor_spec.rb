require 'spec_helper'

describe User do
  
  let(:investor) { FactoryGirl.create(:user, user_type: "investor") }

  subject { investor } 

  it { should respond_to(:user_type) }

  it "should be an investor" do
    expect(investor.user_type).to eq "investor"
  end
end
