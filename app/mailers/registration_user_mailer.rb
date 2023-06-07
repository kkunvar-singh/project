class RegistrationUserMailer < ApplicationMailer

  def welcome_user
    @user = params[:user]
    @otp =  params[:original_otp]
    mail(to: @user.email, subject: 'S.K-Project Please confirmed your account')
  end
end
