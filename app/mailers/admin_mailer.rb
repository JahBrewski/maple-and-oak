class AdminMailer < ActionMailer::Base
  default to: Proc.new { User.where("admin", true).pluck(:email) },
          from: "notifications@mapleandoak.com"

  def user_created(user)
    @user = user
    mail(to: ENV['ADMIN_EMAIL'], subject: "#{@user.full_name} has created a Maple and Oak account")
  end

  def user_destroyed(user)
    @user = user
    mail(to: ENV['ADMIN_EMAIL'], subject: "#{@user.full_name} has deleted their Maple and Oak account")
  end
end
