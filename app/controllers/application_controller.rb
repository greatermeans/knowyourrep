class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :login_required
  helper_method :current_user, :logged_in?

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  def login(user)
    session[:user_id] = @user.id
  end

  def logged_in?
    !!current_user
  end

  def login_required
    if !logged_in?
      redirect_to login_path
    end
  end



end
