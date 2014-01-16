class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :correct_user,    only: :destroy

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to profile_path
    else
      render new_project_path
    end
  end

  def edit
    @project = current_user.projects.find_by(id: params[:id])
  end

  def new
    @project = current_user.projects.build
  end

  def update
    @project= Project.find_by_id(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to profile_path
  end

  private

    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
    rescue
      redirect_to profile_path
    end


    def project_params
      params.require(:project).permit(
        :title,
        :contact_name,
        :email_address,
        :phone_number,
        :description,
        :category,
        :sub_category)
    end

end
