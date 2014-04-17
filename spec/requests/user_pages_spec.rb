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

  describe "investor user" do
    let!(:investor) { FactoryGirl.create(:user, user_type: "investor") }
    let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: investor) }
    before { sign_in investor }

    describe "profile page" do

      context "before user had updated their profile" do
        it "alerts the user to update their profile" do
          visit user_path(investor)
          page.should have_content("Start filling out your profile")
        end
      end
    end
  end

  describe "entrepreneur user" do

    let!(:enterepreneur) { FactoryGirl.create(:user, user_type: "entrepreneur") }
    let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: enterepreneur) }
    before { sign_in enterepreneur }


    describe "profile page" do

      context "before user has updated their profile" do
        it "alerts the user to update their profile" do
          visit user_path(enterepreneur)
          page.should have_content("Start filling out your profile")
        end
      end

      context "after user has updated their profile" do

        let!(:profile) { FactoryGirl.create(:profile, user: enterepreneur) }
        before { visit user_path(enterepreneur) }

        it "displays profile information" do
          page.should have_content(profile.company_name) 
          page.should have_content(profile.location_state_city) 
          page.should have_content(profile.short_description) 
        end

        #it "displays company image" do
        #  page.should have_selector("img[alt='#{profile.company_name}']")
        #end
      end
    end
  end
end
