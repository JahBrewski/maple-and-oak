require 'spec_helper'

describe "Plan pages" do

  subject { page }

  describe "index" do

    describe "for non-signed-in user" do
      before { visit plans_path }
      it { should have_content('Sign in') }
    end

    describe "for signed-in user" do
      let(:user) {FactoryGirl.create(:user) }

      before do
        sign_in user
        visit plans_path
      end

      it { should have_content(user.user_type.capitalize + " plans") }
    end
  end
end
