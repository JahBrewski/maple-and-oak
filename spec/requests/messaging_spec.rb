require 'spec_helper'

describe "Messages" do

  let!(:investor) { FactoryGirl.create(:user, user_type: "investor") }
  let!(:entrepreneur) { FactoryGirl.create(:user, user_type: "entrepreneur") }

  before do
    FactoryGirl.create(:project, user: entrepreneur)
    sign_in investor
  end

  describe "clicking message me button on profile page" do

    before { visit user_path(entrepreneur) }

    it "should show new message form" do
      click_link "Message me"
      page.should have_content "Start Conversation"
    end

    describe "filling out message form with valid information" do
      it "should send a message to the user" do
        expect{
          click_link "Message me"
          fill_in 'conversation_subject', with: "Sample subject"
          fill_in 'conversation_body', with: "Sample body"
          click_button "Save Conversation"
        }.to change(entrepreneur.mailbox.conversations, :count).by(1)
      end
    end
  end
end
