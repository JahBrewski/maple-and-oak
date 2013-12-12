require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Maple and Oak'" do
      visit root_path
      expect(page).to have_content('Maple and Oak')
    end
  end
end
