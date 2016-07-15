class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.get_district
    @user.save
    if @user.errors.messages.present?
      flash.now[:message] = @user.errors.full_messages
      render register_path
    else
      login(@user)
      flash[:message] = 'Welcome to Know Your Rep! You have successfully created an account.'
      redirect_to user_path(@user)
    end
  end

  def show
    if params[:id] == current_user.id.to_s
      @user = User.find(params[:id])
    end
  end

  def update

  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :street_address, :city, :password, :email, :state)
  end

end
