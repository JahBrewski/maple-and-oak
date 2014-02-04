require 'spec_helper'

describe ProjectsController do

  let!(:investor) { FactoryGirl.create(:user, user_type: "investor") }
  let!(:entrepreneur) { FactoryGirl.create(:user, user_type: "entrepreneur") }
  let!(:investor_plan) { FactoryGirl.create(:plan_with_subscription, user: investor, plan_type: "investor") }
  let!(:entrepreneur_plan) { FactoryGirl.create(:plan_with_subscription, user:entrepreneur, plan_type: "entrepreneur") }

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
        response.should redirect_to root_url
      end
    end
  end
end
