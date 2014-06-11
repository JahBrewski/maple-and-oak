require 'spec_helper'

describe "Profiles" do

  let!(:entrepreneur) { FactoryGirl.create(:user, :entrepreneur) }
  let!(:investor) { FactoryGirl.create(:user, :investor) }

  context "when investor is signed in" do

    before do
      sign_in investor
      visit user_path(investor)
    end
  end
  
  context "when entrepreneur is signed in" do

    before do
      sign_in entrepreneur
      visit user_path(entrepreneur)
    end

    describe "Adding a new profile" do

      it "should create a profile" do
        click_link "Start filling out your profile"
        expect { click_button "Update Profile" }.to change(Profile, :count)
      end
    end

    describe "Updating a profile" do

      it "should update profile with new information" do

         FactoryGirl.create(:profile, user: entrepreneur)
         visit user_path(entrepreneur)
         click_link "Edit"
         fill_in_profile_fields
         click_button "Update Profile"

         fields_on_profile = [
           "profile_company_name",
           "profile[state]",
           "profile_city",
           "profile_short_description",
           "profile_long_description",
           "profile[category]",
           "profile_sub_category"]

         profile_text_fields.each do |key, value|
           if fields_on_profile.include?(key)
             page.should have_content value
           end
         end

         profile_select_fields do |key, value|
           if fields_on_profile.include?(key)
             page.should have_content value.inject.last
           end
         end
      end
    end
  end
end
