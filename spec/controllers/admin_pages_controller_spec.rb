require 'spec_helper'

describe AdminPagesController do

  let(:admin) { FactoryGirl.create(:user, admin: true) }
  let(:pending_project) { FactoryGirl.create(:project, status: "pending_approval") }


  describe "GET #dashboard" do

    context "when admin is signed in" do
      before { sign_in admin }

      it "assigns the requested projects to @project" do
        get :dashboard
        assigns(:projects).should include(pending_project)
      end
    end
  end
end


    
