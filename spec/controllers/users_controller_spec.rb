require 'spec_helper'

describe UsersController do

  let!(:admin) { FactoryGirl.create(:user, user_type: "entrepreneur", admin: true) }
  let!(:investor) { FactoryGirl.create(:user, user_type: "investor") }
  let!(:entrepreneur) { FactoryGirl.create(:user, user_type: "entrepreneur") }

  describe "GET #show" do

    context "when entrepreneur is viewing their own page" do
      before { sign_in entrepreneur }

      it "assigns the requested user to @user" do
        get :show, id: entrepreneur
        assigns(:user).should eq(entrepreneur)
      end

      it "renders the #show view for entrepreneur" do
        get :show, id: entrepreneur
        response.should render_template :entrepreneur
      end
    end
    
    context "when entrepreneur is viewing another users page" do
      before { sign_in entrepreneur }

      it "redirects to entrepreneur's own profile" do
        get :show, id: investor
        response.should redirect_to user_url(entrepreneur)
      end
    end

    context "when investor is viewing their own page" do
      before { sign_in investor }

      it "assigns the requested user to @user" do
        get :show, id: investor
        assigns(:user).should eq(investor)
      end

      it "renders the #show view for the investor" do
        get :show, id: investor
        response.should render_template :investor
      end
    end

    context "when investor is viewing another users page" do
      before { sign_in investor }

      it "assigns the requested user to @user" do
        get :show, id: entrepreneur
        assigns(:user).should eq(entrepreneur)
      end

      it "renders the #show view for the other user" do
        get :show, id: entrepreneur
        response.should render_template :entrepreneur
      end
    end

    context "when admin is viewing another user's page" do
      before { sign_in admin }

      it "renders the #show view for the other user" do
        get :show, id: entrepreneur
        response.should be_success
      end
    end
  end
end
