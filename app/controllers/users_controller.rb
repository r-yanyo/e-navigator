class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def apply
    @user = User.find_by(email: params[:user][:email])
    UserMailer.apply_interview(@user,current_user).deliver
    redirect_to user_interviews_path(current_user);
  end

  private
    def interview_params
      params.require(:user).permit(:email)
    end
end
