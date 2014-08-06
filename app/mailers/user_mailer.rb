class UserMailer < ActionMailer::Base
  default from: "notifications@mapleandoak.com"

  def welcome(user)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Maple and Oak!')
  end

  def profile_approved(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(to: @user.email, subject: 'Your Maple and Oak Profile Has Been Approved!')
  end

  def profile_denied(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(to: @user.email, subject: 'Oops. You Need to Work on Your Maple and Oak Profile')
  end

end
