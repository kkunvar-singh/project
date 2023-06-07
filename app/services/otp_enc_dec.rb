
class OtpEncDec
  class << self
    include Rails.application.routes.url_helpers

    def call(type, current_token=nil)
      process(type, current_token)
    end

    def process(type, current_token)
   
      case type
      when 'enc'
        opt_generator
      when 'match_otp'
        match_otp(current_token)
      end
    end

    def opt_generator
      encryptor
    end

    def match_otp(current_otp)
      
      digest_user_otp = Digest::SHA1.hexdigest(current_otp)
      user = find_enc_otp(digest_user_otp)
      {
        valid: user.nil? == false,
        user: user,
        redirect_path: user.nil? ? verify_otps_path(otp: current_otp) : new_session_path
      }
    end

    def encryptor
      rand_otp_generate.
      yield_self { |rand_otp| 
        {
          digest_otp: Digest::SHA1.hexdigest(rand_otp),
          original_otp: rand_otp
        }
      }
    end

    def find_enc_otp(digest_otp)
     
      User.find_by(otp: digest_otp)
    end

    def rand_otp_generate
      "#{rand(1000..9999)}"
    end
  end
end