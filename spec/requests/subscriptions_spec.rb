require 'spec_helper'

describe 'Subscriptions' do

  let(:user) { FactoryGirl.create(:user) }
  let(:plan) { Plan.where(:plan_type => user.user_type).sample } 
  let(:card) { valid_card_data }
  
  subject { page }

  before do
    sign_in user
  end

  describe 'signing up' do

    before do
      visit plans_path
    end

    before do
      click_link plan.name
    end

    context 'with invalid data' do

      it 'displays error messages' do

        click_button "Signup for the #{ plan.name } plan"

        should have_content('Unable to add subscription!')
      end
    end
  end
end
