require 'spec_helper'

feature 'Visitor creates profile' do
  scenario 'as an entrepreneur' do
    sign_up :entrepreneur
    click_link "Start filling out your profile"
    expect(page).to have_content('Profile Details')
  end
  scenario 'as an investor' do
    sign_up :investor
    click_link "Start filling out your profile"
    expect(page).to have_content('Profile Details')
  end
end

