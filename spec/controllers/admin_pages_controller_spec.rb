require 'spec_helper'

describe AdminPagesController do

  let(:admin) { FactoryGirl.create(:user, :entrepreneur, admin: true) }
  let(:non_admin) { FactoryGirl.create(:user, :entrepreneur, admin: false) }
  let(:pending_profile) { FactoryGirl.create(:profile, status: "pending_approval") }


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

      it "assigns profiles with status: 'pending_approval' to @profiles" do
        get :dashboard
        assigns(:profiles).should include(pending_profile)
      end
    end
  end
end


    
