class RequestController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_tutor

  def index
    @requests = Request.left_outer_joins(:responses)
                       .select("requests.*, COUNT(responses.id) AS responses_count").group("requests.id")

    @number_of_students = User.where(role: "student").count
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      flash[:notice] = "Request created successfully"
      redirect_to requests_path
    else
      flash[:error] = @request.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def view
    @request = Request.find(params[:request_id])
    @responses = @request.responses
    @tutor_name = @request.user.name + " " + @request.user.surname
  end

  def delete
    @request = Request.find(params[:request_id])
    if @request.destroy
      flash[:notice] = "Request deleted successfully"
      redirect_to requests_path
    else
      flash[:error] = @request.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def request_params
    params.require(:request).permit(:due_date, dates: []) # Allow "dates" as an array
  end

  def ensure_tutor
    redirect_to root_path unless current_user.tutor?
  end

end
