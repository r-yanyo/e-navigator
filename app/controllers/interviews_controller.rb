class InterviewsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @interviews = @user.interviews
  end
end
