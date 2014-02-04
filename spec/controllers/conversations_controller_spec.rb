require 'spec_helper'

describe ConversationsController do

  describe "GET #index" do
    context "when user is signed in" do

      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
      let(:conversation_to_user) { other_user.send_message( user, "test subject", "hello user").conversation }
      before { sign_in user }

      # need to keep track of initiated conversations
      it "assigns the remaining conversations to @conversations_remaining"

      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  end

  describe "GET #show" do
    context "when user is signed in" do

      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
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

      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
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

    context "with invalid attributes" do
      it "does not create a new conversation"
      it "re-renders the :new template"
    end
  end
end
