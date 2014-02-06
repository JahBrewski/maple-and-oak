require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "Registration Pages" do

    context "with valid attributes" do

      before do
        visit new_user_registration_path
        valid_signup "investor"
      end

      it "creates a new user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end

      it "redirects to plans page" do
        click_button "Sign up"
        page.should have_content("Select Plan")
      end
    end

    context "with invalid attributes" do
      it "does not create a new user" do
        visit new_user_registration_path
        expect { click_button "Sign up" }.not_to change(User, :count) 
      end
    end
  end

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user) }

    before do
      sign_in user
      visit profile_path
    end

    describe "user information" do

      it { should have_content(user.email) }
      it { should have_content(user.user_type.capitalize) }
      it { should have_content(user.full_name) }

      describe "if user has a subscription" do
        let!(:user) { FactoryGirl.create(:user) }
        let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }
        before { visit profile_path }

        it { should have_content(user.subscription.plan.name) }

      end
    end


    describe "when user has created a project" do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: user, user_project_limit: 5) }
      let!(:project) { FactoryGirl.create(:project, user: user) }
      let!(:another_project) { FactoryGirl.create(:project, user: user) }

      before { visit profile_path}

      it { should have_content("Projects") }

      it "should render the user's projects" do
        user.projects.each do |project|
          expect(page).to have_content(project.title)
        end
      end
    end


    describe "when user does not have available projects remaining" do
        let!(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:plan_with_subscription, user: user, user_project_limit: '0')
        visit profile_path
      end

      describe "should not have a link to create a new project" do
        it { should_not have_link('Add project') }
      end
    end

    describe "when user has available projects remaining" do
        let!(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:plan_with_subscription, user: user, user_project_limit: '10')
        visit profile_path
      end

      describe "should have a link to create a new project" do
        it { should have_link('Add project') }

        describe "clicking add project link"  do
          before { click_link "Add project" }
          it "should direct to new project page" do
            current_path.should == new_project_path
          end
        end
      end
    end
  end
end
