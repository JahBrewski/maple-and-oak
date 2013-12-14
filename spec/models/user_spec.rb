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

end

