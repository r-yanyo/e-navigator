class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def notify
    @user = User.find_by(email: params[:user][:email])
    UserMailer.notify_interview(@user,current_user).deliver
  end

  private
    def interview_params
      params.require(:user).permit(:email)
    end
end
