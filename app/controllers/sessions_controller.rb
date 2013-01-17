class SessionsController < ApplicationController
  def new; end

  def create
    user = login(params[:login], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => t('sessions.create.notice')
    else
      flash.now.alert = t('sessions.create.alert')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => t('sessions.destroy.notice')
  end
end