require 'spec_helper'

describe "Project pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  
  before do 
    sign_in user
    FactoryGirl.create(:plan_with_subscription, :user => user, :user_project_limit => '10')
  end

  describe "Adding a new project" do
    before do 
      visit user_path(user)
      click_link "Start filling out your profile"
    end

    describe "with invalid information" do

      it "should not create a project" do
        expect { click_button "Update Profile" }.not_to change(Project, :count)
      end
    end
   
    describe "with valid information" do
      before do
        fill_in 'project_company_name', with: "Sample Project"
        fill_in 'project_contact_name', with: "Jay Z"
        select 'Alabama', :from => 'project[state]'
        fill_in 'project_city', with: "Birmingham"
        fill_in 'project_email_address', with: "jay@z.com"
        fill_in 'project_phone_number',  with: "123-567-7890"
        fill_in 'project_description', with: "I will make music and sell cool clothes."
        select 'Cookie stores', :from => 'project[category]'
        select 'Start up restaurant', from: "project_sub_category"
        click_button "Update Profile"
      end

      describe  "when creating a project" do

        it { should have_content("Sample Project") }
        it { should have_link("edit") }

        describe "edit" do
          before { click_link "edit" }

          describe "page" do
            it { should have_content("Update Project") }

            describe "with valid information" do
              before do 
                fill_in 'project_company_name', with: "Updated Project"
                click_button "Update Profile"
              end

              it { should have_content("Updated Project") }
            end
          end
        end
      end
    end
  end
end
