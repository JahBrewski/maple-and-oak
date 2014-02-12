require 'spec_helper'

describe AdminPagesController do

  let(:admin) { FactoryGirl.create(:user, admin: true) }
  let(:non_admin) { FactoryGirl.create(:user, admin: false) }
  let(:pending_project) { FactoryGirl.create(:project, status: "pending_approval") }


  describe "GET #dashboard" do

    context "when non-admin is signed in" do
      before { sign_in non_admin }

      it "redirects to home page" do
        get :dashboard
        response.should redirect_to root_url
      end
    end

    context "when admin is signed in" do
      before { sign_in admin }

      it "assigns projects with status: 'pending_approval' to @projects" do
        get :dashboard
        assigns(:projects).should include(pending_project)
      end
    end
  end
end


    
