class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def interview_email(user,from_user,interview)
    @user = user
    @from_user = from_user
    @interview = interview
    mail(to: @user.email, cc: @from_user.email, subject: '面接日時が確定しました')
  end

  def notify_email(user,from_user)
    @user = user
    @from_user = from_user
    mail(to: @user.email, cc: @from_user.email, subject: '面接希望日が決まりました')
  end
end
