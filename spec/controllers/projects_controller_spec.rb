require 'spec_helper'

describe ProjectsController do

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

      let!(:project) { FactoryGirl.create(:project, user: investor, category: "sushi") }

      before { sign_in investor }

      it "assigns all projects to @projects" do
        get :index
        assigns(:projects).should include(project)
      end

      it "filters out projects based on search terms" do
        get :index, q: {category_cont: "clothing"}
        assigns(:projects).should_not include(project)
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

    context "when project is not approved" do

      before { sign_in entrepreneur }

      it "doesn't change project's status to published" do
        not_approved_project = FactoryGirl.create(:project, user: entrepreneur, published: false, status: "not_approved")
        put :publish, id: not_approved_project
        not_approved_project.reload
        not_approved_project.published.should eq(false)
      end
    end

    context "when project is approved" do

      before { sign_in entrepreneur }

      it "changes project's status to published" do
        approved_project = FactoryGirl.create(:project, user: entrepreneur, status: "approved", published: false)
        put :publish, id: approved_project
        approved_project.reload
        approved_project.published.should eq(true)
      end
    end
  end
  
  describe "PUT #submit_for_approval" do

    context "when project owner is signed in" do
      before { sign_in entrepreneur }

      it "changes project's status to pending_approval" do
        not_approved_project = FactoryGirl.create(:project, user: entrepreneur, status: "not_approved")
        put :submit_for_approval, id: not_approved_project
        not_approved_project.reload
        not_approved_project.status.should eq("pending_approval")
      end
    end
  end

  describe "PUT #deny" do
    
    context "when admin is signed in" do
      before { sign_in admin }

      it "changes project's status to not_approved" do
        pending_approval_project = FactoryGirl.create(:project, user: entrepreneur, status: "pending_approval")
        put :deny, id: pending_approval_project
        pending_approval_project.reload
        pending_approval_project.status.should eq("not_approved")
      end
    end
  end

  describe "PUT #approve" do

    context "when admin is signed in" do
      before { sign_in admin }

      it "changes project's status to approved" do
        pending_approval_project = FactoryGirl.create(:project, user: entrepreneur, status: "pending_approval")
        put :approve, id: pending_approval_project
        pending_approval_project.reload
        pending_approval_project.status.should eq("approved")
      end
    end
  end
end
