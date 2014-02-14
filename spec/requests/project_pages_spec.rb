require 'spec_helper'

describe "Project pages" do

  let!(:entrepreneur) { FactoryGirl.create(:user, user_type: "entrepreneur") }
  
  context "when entrepreneur is signed in" do

    before do
      sign_in entrepreneur
      visit user_path(entrepreneur)
    end

    describe "Adding a new project" do

      it "should create a project" do
        click_link "Start filling out your profile"
        expect { click_button "Update Profile" }.to change(Project, :count)
      end
    end

    describe "Updating a project" do

      it "should update profile with new information" do

         FactoryGirl.create(:project, user: entrepreneur)
         visit user_path(entrepreneur)
         click_link "Edit"
         fill_in_project_fields
         click_button "Update Profile"

         fields_on_profile = [
           "project_company_name",
           "project[state]",
           "project_city",
           "project_short_description",
           "project_long_description",
           "project[category]",
           "project_sub_category"]

         project_text_fields.each do |key, value|
           if fields_on_profile.include?(key)
             page.should have_content value
           end
         end

         project_select_fields do |key, value|
           if fields_on_profile.include?(key)
             page.should have_content value.inject.last
           end
         end
      end
    end
  end
end
