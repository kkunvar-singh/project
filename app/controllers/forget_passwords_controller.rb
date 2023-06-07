class ForgetPasswordsController < ApplicationController
  def index
  end

  def create
    user = find_user_by_email(current_email)
    user.present? ? valid_email_process(user) : invalid_email_process
  end

  def current_email
    params[:email]
  end

  def find_user_by_email(email)
    User.find_by(email: email)
  end

  def valid_email_process(user)
    otp_hash = ::OtpEncDec.call('enc')
    ForgetUserPasswordMailer.with(user: user, original_otp: otp_hash[:original_otp]).foreget_password.deliver_now
    user.assign_attributes({ otp: otp_hash[:digest_otp], type_otp: User.type_otps[:forget_password], otp_send_at: Time.current })
    user.save(validate: false)
    redirect_to new_session_path, notice: 'Please check your register mail id we are send forget password link'
  end

  def invalid_email_process
    redirect_to forget_passwords_path, alert: 'Invalid mail id'
  end
end
