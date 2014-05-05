class UserMailer < ActionMailer::Base
  default from: "notifications@mapleandoak.com"

  def welcome(user)
    @user = user
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Maple and Oak!')
  end
end
