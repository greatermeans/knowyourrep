class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.state_id = State.find_by(abbreviation: params[user][state]).id
    # need to figure out how to get district id.
    @user.save
  end

  def show
    @user = User.find(params[:id])
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
