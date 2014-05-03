require 'spec_helper'

feature 'Visitor fills out profile' do
  feature 'as an entrepreneur' do
    scenario 'for a startup' do
      sign_up :entrepreneur
      click_link "Start filling out your profile"
      select "Start up restaurant" 
      expect(find('#profit-loss').visible?).to eq(false)
    end
    scenario 'for a purchase' do
      sign_up :entrepreneur
      click_link "Start filling out your profile"
      select "Purchase an existing restaurant" 
      expect(find('#profit-loss').visible?).to eq(true)
    end
  end
end

    
