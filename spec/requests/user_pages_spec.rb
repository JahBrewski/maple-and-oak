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

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user) }
    let(:plan) { Plan.where(:plan_type => user.user_type).sample }
    let(:card) do 
    { :number => '4242424242424242', :exp_month => '11', :exp_year => '2020' }
    end

    before do
      sign_in user
      FactoryGirl.create(:subscription, :stripe_card_token => card, :user => user, :plan_id => plan.id)
      visit profile_path
    end


    it { should have_content(user.email) }
    it { should have_content(user.user_type.capitalize) }
    it { should have_content(user.full_name) }

    describe "when user has available projects remaining" do
      before { user.plan.user_project_limit = 10 }

      describe "should have a link to create a new project" do
        it { should have_link('Add a Project!') }
      end

    end
  end
end
