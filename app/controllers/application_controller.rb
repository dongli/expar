class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  def authenticate_user(upstream_params)
    if upstream_params[:format] == 'json'
      user_params = params[:user].presence
      user_params ||= params
      email = user_params[:email].presence
      error!('User email is not provided.', 401) if not email
      password = user_params[:password].presence
      error!('User password is not provided.', 401) if not password
      user = User.find_by_email(email)
      error!('User does not exist.', 401) if not user
      error!('Password is not correct.') if not user.valid_password?(password)
      sign_in user, store: false
    else
      authenticate_user!
    end
  end
end
