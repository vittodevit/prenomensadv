class ResponseController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_student
  before_action :set_request, only: [:new, :create]

  def new
    # check if the student has already responded
    if @request.responses.where(user_id: current_user.id).exists?
      redirect_to root_path
    end

    @response = @request.responses.new
    @tutor_name = @request.user.name + " " + @request.user.surname
  end

  def create
    @response = @request.responses.new(request_params)
    @response.user_id = current_user.id
    @response.request_id = @request.id

    if @response.save
      flash[:notice] = "Response created successfully"
      redirect_to root_path
    else
      flash[:error] = @response.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ensure_student
    redirect_to root_path unless current_user.student?
  end

  def request_params
    params.require(:response).permit(days: []) # Allow "dates" as an array
  end

  def set_request
    @request = Request.find(params[:request_id])
  end

end
