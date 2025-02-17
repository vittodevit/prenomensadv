include HomeHelper
class HomeController < ApplicationController
  PAGE_URL = "https://aiuto.elis.org/menu/"
  def index
    @menu_data = fetch_menu_data(PAGE_URL)

    if current_user&.student?
      @requests_without_response = Request.where.not(
        id: Response.where(user_id: current_user.id).pluck(:request_id),
      ).where("due_date > ?", Date.today)
    else
      @requests_without_response = []
    end

    render :index
  end

end
