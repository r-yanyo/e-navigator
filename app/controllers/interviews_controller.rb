class InterviewsController < ApplicationController
  before_action :authenticate_user!, :setInterview
  
  def index
    id = params[:id]
    if id == nil
      @user = current_user
      @interviews = @user.interviews
    else
      @user = User.find_by(id: id)
      if @user
        @interviews = @user.interviews
      else
        render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
      end
    end
  end

  def new
    @user = current_user
    @interview = Interview.new()
  end

  def create
    @interview = Interview.new(interview_params)
    @interview.acceptance = "保留"
    if @interview.save
      redirect_to interviews_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    if @interview.update_attributes(interview_params)
      redirect_to interviews_path
    else
      render 'edit'
    end
  end

  def delete
    @interview.destroy
    redirect_to interviews_path
  end

  private
    
    def interview_params
      params.require(:interview).permit(:date, :acceptance, :user_id)
    end

    def setInterview
      @interview = Interview.find_by(id: params[:id])
    end
end
