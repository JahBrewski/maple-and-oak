require 'spec_helper'

describe ConversationsController do

  describe "GET #index" do
    context "when user is signed in" do

      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
      let(:conversation_to_user) { other_user.send_message( user, "test subject", "hello user").conversation }
      before { sign_in user }

      it "populates inbox array" do
        get :index
        assigns(:inbox).should eq([conversation_to_user])
      end
        
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

      it "renders the :show template"

    end
  end
end
