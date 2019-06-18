class UserMailer < ApplicationMailer
  default from: 'noreply@railsfacebook.com'

  def welcome_email
    @user = params[:user]
    @url = signin_url
    mail(to: @user.email, subject: 'Welcome to Rails Facebook!')
  end
end
