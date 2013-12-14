require 'spec_helper'

describe Plan do

  it { should respond_to(:price) }
  it { should respond_to(:plan_type) }
  it { should respond_to(:plan_level) }
  it { should respond_to(:user_project_limit) }
end
