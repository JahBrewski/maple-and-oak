class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :investor_only, only: :index

  def create
    @project = current_user.create_project(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to profile_path
    else
      render new_project_path
    end
  end

  def index
    @search = Project.search(params[:q])
    @projects = @search.result
  end

  def edit
    @project = current_user.project
  end

  def new
    @project = current_user.build_project
    @categories = ProjectCategory.all
  end

  def update
    @project = current_user.project
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  def destroy
    current_user.project.destroy
    redirect_to profile_path
  end

  private

    def project_params
      params.require(:project).permit(
        :business_plan,
        :company_image,
        :city,
        :state,
        :company_name,
        :contact_name,
        :email_address,
        :phone_number,
        :description,
        :category,
        :sub_category)
    end

end
