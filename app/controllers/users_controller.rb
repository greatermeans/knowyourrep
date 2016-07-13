class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.state = State.find_by(abbreviation: params[:user][:state])
    @user.district = @user.get_district
    @user.save
    login(@user)
    flash[:message] = 'Welcome to Know Your Rep! You have successfully created an account.'
    redirect_to user_path(@user)

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
    params.require(:user).permit(:name, :street_address, :city, :zipcode, :email)
  end

end
