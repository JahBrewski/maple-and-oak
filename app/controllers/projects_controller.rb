class ProjectsController < ApplicationController
  before_action :correct_user,    only: :destroy

  def new
    @project = current_user.projects.build
  end

end
