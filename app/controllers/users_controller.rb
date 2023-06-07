class UsersController < ApplicationController
    before_action :check_current_user, only: [:edit, :destroy, :search]
    

    def index
      @users = User.all.order(:first_name) 
    end

    def search  

      activatedkey = params[:activatedkey].downcase
      activated_status = activatedkey == "true" || activatedkey == "false" ?  User.where("users.activated LIKE ?",["#{activatedkey}"]) : User.all

      if params[:key].present?
        @key = params[:key].downcase
        @users = activated_status.joins(:address).where("addresses.city LIKE ? or users.first_name LIKE ? or users.last_name LIKE ? or users.email LIKE ? ", ["#{@key}"],["#{@key}"], ["#{@key}"],["#{@key}"])
        render "index"
        
      else
        redirect_to root_path, notice: "No results found"
      end
    end
   
    def show 
        @user = User.find(params[:id])
    end

    def new 
        @user = User.new
        @user.build_address
    end

    def create 
      @user = User.new(user_params)
      set_default_role(@user)
      user_with_original_otp = set_otp_user_valid(@user)
      @user = user_with_original_otp[:user]
      if @user.save
        RegistrationUserMailer.with(user: @user, original_otp: user_with_original_otp[:original_otp]).welcome_user.deliver_now
        redirect_to new_session_path, notice: "Please Check register mail id"
      else
        render :new, status: :unprocessable_entity
      end
    end

    
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to root_path, notice: "User Successfully Update!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end

  private
    

    def set_default_role(user)
      @user.role = :user
    end

    def set_otp_user_valid(user)
      otp_hash = ::OtpEncDec.call('enc')
      if user.valid?
        user.assign_attributes({ otp: otp_hash[:digest_otp], type_otp: User.type_otps[:record_create], otp_send_at: Time.current }) 
      end
      {
        user: user,
        original_otp: otp_hash[:original_otp]
      }
    end

    def check_current_user
      redirect_to root_path, alert: "you are not athorizi" unless current_user.id.to_s  == params[:id] or current_user.role == "admin"
    end

    def user_params
      params.require(:user)
      .permit(:first_name, :last_name, :mobail_number, :email, :date_of_birth, :activated, :role, :password, :password_confirmation,
          address_attributes: [:parmanent_address, :residencial_address, :city, :state, :country, :pin])
  end

end
