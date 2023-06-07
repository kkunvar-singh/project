class EducationsController < ApplicationController
    before_action :verify_auth_user

    def index
        @educations = Education.all 
    end

    def show
        @education = Education.find(params[:id])
    end

    def new 
        @education = Education.new
    end

    def create
        @education = Education.new(education_params)
        if @education.save
            redirect_to root_path, notice: "Education  Successfully Create"
        else
            render :new, status: :unprocessable_entity
        end
    end


  def edit
    @education = Education.find(params[:id])
  end

  def update
    @education = Education.find(params[:id])
    if @education.update(education_params)
        redirect_to education_path, notice: "User Successfully Update!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

    
  def destroy
    @education = Education.find(params[:id])
    @education.destroy

    redirect_to root_path, status: :see_other
  end


    private

    def education_params
        params.require(:education).permit( :institude_name, :university, :course, :stream, :marks, :passed_year, :parsentage)
    end
end
