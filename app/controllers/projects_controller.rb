class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter(:only => [:index]) { |c| c.authorized_users_and_admin_only ["investor"] } 
  before_filter :admin, only: [:approve, :deny]
  before_action :correct_user, only: [:edit, :update, :submit_for_approval]
  before_filter :approved?, only: [:publish]
  before_filter :active_subscription?

  def approve
    @project = Project.find(params[:id])
    @project.update_status_with("approved")
    redirect_to admin_path
  end

  def deny
    @project = Project.find(params[:id])
    @project.update_status_with("not_approved")
    redirect_to admin_path
  end

  def submit_for_approval
    @project = Project.find(params[:id])
    @project.update_status_with("pending_approval")
    redirect_to user_path(current_user)
  end

  def publish
    @project = Project.find(params[:id])
    @project.publish
    redirect_to user_path(current_user)
  end

  def unpublish
    @project = Project.find(params[:id])
    @project.unpublish
    redirect_to user_path(current_user)
  end

  def update_status
    @project = Project.find(params[:id])
  end

  def create
    @project = current_user.create_project(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to user_path(current_user)
    else
      render new_project_path
    end
  end

  def index
    published = Project.where(published: true)
    @search = published.search(params[:q])
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
      redirect_to user_path(current_user)
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
        :business_plan_cache,
        :company_image_cache,
        :company_image,
        :city,
        :state,
        :company_name,
        :contact_name,
        :contact_email_address,
        :contact_phone_number,
        :short_description,
        :long_description,
        :category,
        :user_hospitality_experience,
        :user_management_experience,
        :user_highest_position,
        :user_current_position,
        :user_current_restaurant_owner?,
        :user_previous_restaurant_owner?,
        :sub_category)
    end

    # before filters

    def correct_user
      @user = Project.find(params[:id]).user
      redirect_to(root_url) unless current_user == @user
    end

    def approved?
      @project = Project.find(params[:id])
      redirect_to(current_user) unless @project.status == "approved" 
    end

    def admin
      current_user.admin?
    end
end
