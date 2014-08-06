class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter(:only => [:index]) { |c| c.authorized_users_and_admin_only ["investor"] } 
  
  before_filter :admin, only: [:approve, :deny]
  before_filter :active_subscription?

  before_action :profile_owner, only: [:edit, :update, :submit_for_approval]
  before_action :get_profile, only: [:approve, :deny, :submit_for_approval, :publish, :unpublish]
  before_action :is_approved?, only: [:index]

  def approve
    @profile.update_status_with("approved")
    UserMailer.profile_approved(@profile.user).deliver
    redirect_to admin_path
  end

  def deny
    @profile.update_status_with("not_approved")
    UserMailer.profile_denied(@profile.user).deliver
    redirect_to admin_path
  end

  def submit_for_approval
    @profile.update_status_with("pending_approval")
    redirect_to user_path(current_user)
  end

  def publish
    if @profile.approved?
      @profile.publish
    end
    redirect_to user_path(current_user)
  end

  def unpublish
    @profile.unpublish
    redirect_to user_path(current_user)
  end

  def create
    @profile = current_user.create_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile created!"
      redirect_to user_path(current_user)
    else
      render new_profile_path
    end
  end

  def index
    published = Profile.where(published: true)
    @search = published.search(params[:q])
    @profiles = @search.result
  end

  def edit
    @profile = current_user.profile
  end

  def new
    @profile = current_user.build_profile
    @categories = ProfileCategory.all
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    current_user.profile.destroy
    redirect_to profile_path
  end

  private

    def profile_params
      params.require(:profile).permit(
        :address,
        :assets_business_holdings,
        :assets_liquid,
        :assets_marketable_securities,
        :assets_notes_receivable,
        :assets_personal,
        :assets_real_estate,
        :assets_total,
        :business_experience,
        :business_plan,
        :business_plan_cache,
        :category,
        :city,
        :company_image,
        :company_image_cache,
        :company_name,
        :contact_email_address,
        :contact_name,
        :contact_phone_number,
        {:familiarity_ids => []},
        :investment_type,
        :investment_amount,
        :liabilities_notes_payable,
        :liabilities_accounts_payable,
        :liabilities_auto_loans,
        :liabilities_mortgage,
        :liabilities_other,
        :liabilities_total,
        :long_description,
        :net_worth,
        :partner_type,
        :previous_restaurant_status,
        :short_description,
        :seat_number,
        :state,
        :sub_category,
        :user_current_position,
        :user_current_restaurant_owner,
        :user_highest_position,
        :user_hospitality_experience,
        :user_management_experience,
        :user_previous_restaurant_owner,
        :user_serv_safe_certified)
    end

    # before filters
    
    def is_approved?
      unless current_user.profile && current_user.profile.approved?
        redirect_to(user_path(current_user))
        flash[:notice] = "Sorry. Your profile must be approved before you can browse other users."
      end
    end

    def profile_owner
      @user = Profile.find(params[:id]).user
      redirect_to(root_url) unless current_user == @user
    end

    def admin
      current_user.admin?
    end

    def get_profile
      @profile = Profile.find(params[:id])
    end
end
