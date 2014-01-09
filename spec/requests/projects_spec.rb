require 'spec_helper'

describe "Projects" do
  let(:user) { FactoryGirl.create(:user) }

  describe "Adding a new project" do

    it "should add a new project" do
      @project = user.projects.build(:title => "New Project")
      expect { @project.save }.to change(Project, :count).by(1)
    end

    it "should not add a new project if user does not have projects remaining"
  end
  
  describe "Removing a project" do
    it "should remove the project if the user is correct"
    it "should not remove the project if the user is not correct"
  end

end

