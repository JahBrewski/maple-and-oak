require 'spec_helper'

describe ProfilesController do

  let!(:admin) { FactoryGirl.create(:user, user_type: "investor", admin: true) }
  let!(:investor) { FactoryGirl.create(:user, user_type: "investor") }
  let!(:entrepreneur) { FactoryGirl.create(:user, user_type: "entrepreneur") }
  let!(:investor_plan) { FactoryGirl.create(:plan_with_subscription, user: investor, plan_type: "investor") }
  let!(:entrepreneur_plan) { FactoryGirl.create(:plan_with_subscription, user: entrepreneur, plan_type: "entrepreneur") }

  describe "GET #index" do

    context "when user is not signed in" do
      it "redirects to sign up page" do
        get :index
        response.should redirect_to new_user_session_url
      end
    end

    context "when investor is signed in" do

      let!(:profile) { FactoryGirl.create(:profile, user: investor, category: "sushi") }

      before { sign_in investor }

      it "assigns all profiles to @profiles" do
        get :index
        assigns(:profiles).should include(profile)
      end

      it "filters out profiles based on search terms" do
        get :index, q: {category_cont: "clothing"}
        assigns(:profiles).should_not include(profile)
      end
    end

    context "when entrepreneur is signed in" do

      before { sign_in entrepreneur }

      it "redirects to root url" do
        get :index
        response.should redirect_to user_url(entrepreneur)
      end
    end
  end

  describe "PUT #publish" do

    context "when profile is not approved" do

      before { sign_in entrepreneur }

      it "doesn't change profile's status to published" do
        not_approved_profile = FactoryGirl.create(:profile, user: entrepreneur, published: false, status: "not_approved")
        put :publish, id: not_approved_profile
        not_approved_profile.reload
        not_approved_profile.published.should eq(false)
      end
    end

    context "when profile is approved" do

      before { sign_in entrepreneur }

      it "changes profile's status to published" do
        approved_profile = FactoryGirl.create(:profile, user: entrepreneur, status: "approved", published: false)
        put :publish, id: approved_profile
        approved_profile.reload
        approved_profile.published.should eq(true)
      end
    end
  end
  
  describe "PUT #submit_for_approval" do

    context "when profile owner is signed in" do
      before { sign_in entrepreneur }

      it "changes profile's status to pending_approval" do
        not_approved_profile = FactoryGirl.create(:profile, user: entrepreneur, status: "not_approved")
        put :submit_for_approval, id: not_approved_profile
        not_approved_profile.reload
        not_approved_profile.status.should eq("pending_approval")
      end
    end
  end

  describe "PUT #deny" do
    
    context "when admin is signed in" do
      before { sign_in admin }

      it "changes profile's status to not_approved" do
        pending_approval_profile = FactoryGirl.create(:profile, user: entrepreneur, status: "pending_approval")
        put :deny, id: pending_approval_profile
        pending_approval_profile.reload
        pending_approval_profile.status.should eq("not_approved")
      end
    end
  end

  describe "PUT #approve" do

    context "when admin is signed in" do
      before { sign_in admin }

      it "changes profile's status to approved" do
        pending_approval_profile = FactoryGirl.create(:profile, user: entrepreneur, status: "pending_approval")
        put :approve, id: pending_approval_profile
        pending_approval_profile.reload
        pending_approval_profile.status.should eq("approved")
      end
    end
  end
end
