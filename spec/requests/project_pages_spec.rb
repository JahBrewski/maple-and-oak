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
      visit profile_path
      click_link "Add project"
    end

    describe "with invalid information" do

      it "should not create a project" do
        expect { click_button "Save Project" }.not_to change(Project, :count)
      end
    end
   
    describe "with valid information" do
      before do
        fill_in 'project_title', with: "Sample Project"
        fill_in 'project_contact_name', with: "Jay Z"
        select 'Alabama', :from => 'project[state]'
        fill_in 'project_city', with: "Birmingham"
        fill_in 'project_email_address', with: "jay@z.com"
        fill_in 'project_phone_number',  with: "123-567-7890"
        fill_in 'project_description', with: "I will make music and sell cool clothes."
        select 'Cookie stores', :from => 'project[category]'
        select 'Start up restaurant', from: "project_sub_category"
      end

      describe  "should create a project" do
        before { click_button "Save Project" }

        it { should have_content("Profile") }
        it { should have_content("Sample Project") }
        it { should have_link("edit") }

        describe "edit" do
          before { click_link "edit" }

          describe "page" do
            it { should have_content("Update Project") }

            describe "with valid information" do
              before do 
                fill_in 'project_title', with: "Updated Project"
                click_button "Save Project"
              end

              it { should have_content("Updated Project") }
            end
          end
        end

        describe "Project destruction" do

          describe "as correct user" do
            before { visit profile_path }

            it "should delete the project" do
              expect { click_link "delete" }.to change(Project, :count).by(-1)
            end
          end
        end
      end
    end
  end
end
