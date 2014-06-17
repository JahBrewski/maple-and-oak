require 'spec_helper'

feature 'User visits profile' do
  scenario 'with inactive subscription' do
    user = FactoryGirl.create(:user, :entrepreneur, :active_subscription => false)
    sign_in user
    visit user_path(user)
    page.should have_content "Inactive subscription"
  end
end

