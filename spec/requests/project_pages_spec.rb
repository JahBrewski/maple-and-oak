require 'spec_helper'

describe "Project pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  
  before do 
    sign_in user
    FactoryGirl.create(:plan_with_subscription, user: user)
  end

  describe "Adding a new project" do

    it "should create a project" do
      visit user_path(user)
      click_link "Start filling out your profile"
      expect { click_button "Update Profile" }.to change(Project, :count)
    end
  end
end
