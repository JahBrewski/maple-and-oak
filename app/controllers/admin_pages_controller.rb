class AdminPagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user

  def dashboard 
    @profiles = Profile.where(status: "pending_approval")
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

