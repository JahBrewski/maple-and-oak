require 'spec_helper'

describe MessagesController do

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    let!(:sender) { FactoryGirl.create(:user) }
    let!(:receiver) { FactoryGirl.create(:user) }

    before { sign_in sender }
    it "sends a message to the recipient" do
      expect {
        post :create, recipients: FactoryGirl.create(:user), subject: "test subject", body: "test body"
      }.to change(
      it "redirects to ??? page"
    end

    context "with invalid attributes" do
      it "does not save the new message in the database"
      it "re-renders the :new template"
    end
  end
end
