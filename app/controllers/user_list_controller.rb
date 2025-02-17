class UserListController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_tutor

  def index
    @users = User.where(role: "student")
  end

  def delete
    user = User.find(params[:id])
    if user.tutor?
      flash[:error] = "Non sei autorizzato a eseguire questa azione."
      redirect_to user_list_path
      return
    end
    user.destroy
    redirect_to user_list_path, notice:
  end
  def approve
    user = User.find(params[:id])
    if user.tutor?
      flash[:error] = "Non sei autorizzato a eseguire questa azione."
      redirect_to user_list_path
      return
    end
    unless user.update_column(:approved_from_tutor, true)
      flash[:error] = "Errore durante l'approvazione."
    end
    redirect_to user_list_path, notice:
  end

  private

  def ensure_tutor
    redirect_to root_path unless current_user.tutor?
  end

end
