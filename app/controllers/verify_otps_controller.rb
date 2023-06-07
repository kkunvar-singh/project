class VerifyOtpsController < ApplicationController

  def index
  end
  
  def verify_user_otp
    otp = otp_params
    otp_response = ::OtpEncDec.call('match_otp', otp)
    if otp_response[:valid]
      update_user_otp_nil(otp_response[:user])
      redirect_to new_session_path, generate_message(otp_response[:valid], 'create')  and return
    end
     
    redirect_to otp_response[:redirect_path]
  end

  def new_password
  end

  def verify_user_forget_password
    otp = otp_params
    otp_response = ::OtpEncDec.call('match_otp', otp)
    if otp_response[:valid]
      update_user_otp_nil_and_password(otp_response[:user])
      if !otp_response[:user].valid?
        redirect_to new_password_verify_otps_path(otp: params[:otp]), alert: otp_response[:user].errors.full_messages.join(', ')
      else
        redirect_to new_session_path, generate_message(otp_response[:valid], 'forget_password')
      end
    else
      redirect_to new_password_verify_otps_path(otp: otp), generate_message(otp_response[:valid], 'forget_password')
    end
  end

  def update_user_otp_nil(user)
    user.assign_attributes({ otp: nil, otp_send_at: nil, type_otp: User.type_otps[:confirmed] })
    user.save(validate: false)
  end

  def update_user_otp_nil_and_password(user)
    user.assign_attributes(
      { 
        otp: nil, 
        otp_send_at: nil, 
        type_otp: User.type_otps[:confirmed], 
        password: params[:password], 
        password_confirmation: params[:password_confirmation]
      }
    )
    user.save
  end

  def otp_params
    params[:otp]
  end

  def generate_message(is_valid, type)
    notice_msg = type == 'create' ? 'Your account has been confirmed..!' : 'Your password updated successfuly'
    is_valid ? notice_message(notice_msg) : alert_message('Invalid OTP')
  end

  def notice_message(msg)
    {
      notice: msg
    }
  end

  def alert_message(msg)
    {
      alert: msg
    }
  end

end
