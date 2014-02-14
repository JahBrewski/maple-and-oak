require 'spec_helper'

describe ConversationsController do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user) }
  before { FactoryGirl.create(:plan_with_subscription, user: user) }

  describe "GET #index" do
    context "when user does not have an active subscription" do
      before { sign_in user }
      it "redirects user to plans page" do
        user.update_attribute(:active_subscription, false)
        user.reload
        get :index
        response.should redirect_to plans_path
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

  describe "GET #show" do
    context "when user is signed in" do

      let(:conversation_to_user) { other_user.send_message( user, "test subject", "hello user").conversation }
      before { sign_in user }

      it "assings the requested conversation to @conversation" do
        get :show, id: conversation_to_user
        assigns(:conversation).should eq(conversation_to_user)
      end

      it "renders the :show template" do
        get :show, id: conversation_to_user
        response.should render_template :show
      end

    end
  end

  describe "POST #create" do
    context "with valid attributes" do

      let(:conversation_to_user) { other_user.send_message( user, "test subject", "hello user").conversation }
      before { sign_in user }
      
      it "creates a new conversation" do
        expect{
          post :create, conversation: FactoryGirl.attributes_for(:conversation, recipients: other_user.email)
        }.to change(other_user.mailbox.inbox, :count).by(1)
      end

      it "redirects to the conversations page" do
        post :create, conversation: FactoryGirl.attributes_for(:conversation, recipients: other_user.email)
        response.should redirect_to conversations_path
      end
    end
  end
end
