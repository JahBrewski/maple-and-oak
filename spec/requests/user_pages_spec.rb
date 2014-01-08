require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before {visit new_user_registration_path }

    it { should have_content('Sign up') }

    describe "with valid information" do
      before { valid_signup "investor" }

      it "should create a new user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Sign up" }
          let(:user) { User.find_by(email: 'user@example.com') }

          it { should have_link('Sign out') }
          it { should have_link('Profile') }
          it { should have_content('Select Plan') }
          
      end
    end
  end
end
