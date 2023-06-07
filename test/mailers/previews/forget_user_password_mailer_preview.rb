# Preview all emails at http://localhost:3000/rails/mailers/forget_user_password_mailer
class ForgetUserPasswordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/forget_user_password_mailer/foreget_password
  def foreget_password
    ForgetUserPasswordMailer.with(user: User.first, original_otp: '1231').foreget_password
  end
end
