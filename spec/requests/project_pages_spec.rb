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

         project_text_fields = { 
           project_company_name: "Jay's Cookies",
           project_contact_name: "Jay Z",
           project_city: "Birmingham",
           project_contact_email_address: "jay@z.com",
           project_contact_phone_number: "123-456-7890",
           project_short_description: "I will bake delicious cookies.",
           project_long_description: "I will bake the best cookies in the entire world. The entire universe will ingest my creations and become better because of them. One day my cookies might just take over the world. Consider yourself forewarned.",
           project_user_current_position: "Head Chef/Owner at Bluebird Cafe",
           project_user_highest_position: "Head Chef/Owner at Bluebird Cafe",
           project_user_current_restaurant_owner: "Yes, I own/operate Bluebird Cafe",
           project_user_previous_restaurant_owner: "Yes, I own/operate Bluebird Cafe",
         }
         project_text_fields.each do |key, value|
           fill_in key, with: value
         end

         #fill in project details
         select 'AL', :from => 'project[state]'
         select 'Cookie stores', :from => 'project[category]'
         select 'Start up restaurant', from: "project_sub_category"
        
         #fill in user details
         select '2-5', :from => 'project[user_hospitality_experience]'
         select '2-5', :from => 'project[user_management_experience]'

         click_button "Update Profile"

         #project details
         ["Jay's Cookies",
          "Alabama",
          "Birmingham",
          "I will bake delicious cookies.",
          "I will bake the best cookies in the entire world. The entire universe will ingest my creations and become better because of them. One day my cookies might just take over the world. Consider yourself forewarned.",
          "cookie store",
          "startup"].each do |detail|
           page.should have_content detail
          end

         #user details
         #page.should have_content "2-5"
         #page.should have_content "Head Chef/Owner at Bluebird Cafe"
         #page.should have_content "Yes, I own/operate Bluebird Cafe"
         
      end
    end
  end
end
