require 'spec_helper'

feature 'Visitor fills out profile', js: true do
  feature 'as an entrepreneur' do
    scenario 'for a startup' do
      valid_signup "entrepreneur"

      click_link "Start filling out your profile"
      select "Start up restaurant" 
      expect(find('#profit-loss').visible?).to eq(false)
    end
    scenario 'for a purchase', js: true do
      valid_signup "entrepreneur"
      click_link "Start filling out your profile"
      select "Purchase an existing restaurant" 
      expect(find('#profit-loss').visible?).to eq(true)
    end
  end
end

    
