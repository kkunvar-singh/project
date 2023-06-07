# Preview all emails at http://localhost:3000/rails/mailers/registration_user_mailer
class RegistrationUserMailerPreview < ActionMailer::Preview
  def welcome_user
    RegistrationUserMailer.with(user: User.first, original_otp: '9891').welcome_user
  end
end
