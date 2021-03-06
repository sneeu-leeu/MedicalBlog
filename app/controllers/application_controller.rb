class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # include ActionController::RequestForgeryProtection
  # protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :authenticate_with_token
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :surname, :email, :password,
               :current_password)
    end
  end

  def authenticate_with_token
    return unless params[:apitoken]

    user = User.find_by_api_token(params[:apitoken])
    sign_in(user)
  end
end
