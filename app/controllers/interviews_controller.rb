class InterviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_interview, only: [:edit, :update, :destroy, :update_acceptance]
  
  def index
    @user = User.find_by(id: params[:user_id])
    if @user
      @interviews = @user.interviews.order(:date)
      @users = User.where.not(id: current_user.id)
      @emails = @users.pluck("email")
    else
      render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
    end
  end

  def new
    @user = current_user
    @interview = Interview.new()
  end

  def create
    @interview = Interview.new(interview_params)
    @interview.acceptance = "hold"
    if @interview.save
      redirect_to user_interviews_path(current_user.id)
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find_by(id: @interview.user_id)
    if @interview.update_attributes(interview_params)
      redirect_to user_interviews_path(current_user.id)
    else
      redirect_to edit_user_interview_path(current_user.id)
    end
  end

  def update_acceptance
    @user = User.find_by(id: @interview.user_id)
    @interviews = @user.interviews
    @interviews.where.not(id: @interview.id).update_all(acceptance: "reject")
    @interview.update_attribute(:acceptance, "accept")

    UserMailer.confirm_interview(@user,current_user,@interview).deliver

    redirect_to user_interviews_path(@user.id)
  end

  def destroy
    @interview.destroy
    redirect_to user_interviews_path(current_user.id)
  end

  private
    def interview_params
      params.require(:interview).permit(:date, :user_id)
    end

    def set_interview
      @interview = Interview.find_by(id: params[:id])
    end
end
