require 'spec_helper'

describe ProjectsController do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:plan) { FactoryGirl.create(:plan_with_subscription, user: user) }

  describe "GET #index" do

    context "when user is not signed in" do
      it "redirects to sign up page" do
        get :index
        response.should redirect_to new_user_session_url
      end
    end

    context "when user is signed in" do

      let!(:project) { FactoryGirl.create(:project, user: user, category: "sushi") }

      before { sign_in user }

      it "assigns all projects to @projects" do
        get :index
        assigns(:projects).should include(project)
      end

      it "filters out projects based on search terms" do
        get :index, q: {category_cont: "clothing"}
        assigns(:projects).should_not include(project)
      end
    end
  end
end
