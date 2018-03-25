class InterviewsController < ApplicationController
  before_action :authenticate_user!
  
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
end
