require 'spec_helper'

describe ConversationsController do

  let!(:user) { FactoryGirl.create(:user, :entrepreneur) }
  let!(:other_user) { FactoryGirl.create(:user, :entrepreneur) }
  before { FactoryGirl.create(:plan_with_subscription, user: user) }

  describe "GET #index" do
    context "when user does not have an active subscription" do
      before { sign_in user }
      it "redirects user to signup page" do
        user.update_attribute(:active_subscription, false)
        user.reload
        get :index
        response.should redirect_to signup_path
      end
    end
      

    context "when user is signed in and has an active subscription" do

      before { sign_in user }

      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  end
end
