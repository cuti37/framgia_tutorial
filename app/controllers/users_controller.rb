class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: :show
  before_action :admin_user, only: :destroy

  def index
    @users = User.select(:id, :name, :email, :admin).activated.order(:id)
      .paginate page: params[:page], per_page: Settings.user.user_per_page
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:success] = t ".check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash[:danger] = t ".update_error"
      render :edit
    end
  end

  def destroy
    flash[:success] = t ".delete_success"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end

    def load_user
      @user = User.find_by id: params[:id]

      if @user.nil?
        flash[:warning] = t ".not_found"
        redirect_to root_path
      end
    end

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to root_url unless @user.is_current_user? @user
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t ".log_in_please"
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
