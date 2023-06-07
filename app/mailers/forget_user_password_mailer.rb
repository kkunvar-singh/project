class ForgetUserPasswordMailer < ApplicationMailer

  def foreget_password
    @user = params[:user]
    @otp =  params[:original_otp]
    mail(to: @user.email, subject: 'S.K-Project Forget Password!')
  end
end