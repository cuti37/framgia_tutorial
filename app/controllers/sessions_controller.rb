class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      flash[:success] = t ".success_login"
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t ".error_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
