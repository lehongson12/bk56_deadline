class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  helper_method :current_user
 def new_session_path(scope)
    new_user_session_path
  end
  
 	protected

	def configure_devise_permitted_parameters
	    registration_params = [:name, :email, :birthday, :website, :bio, :phone, :location, :password, :password_confirmation]

	    if params[:action] == 'update'
	      devise_parameter_sanitizer.for(:account_update) { 
	        |u| u.permit(registration_params << :current_password)
	      }
	    elsif params[:action] == 'create'
	      devise_parameter_sanitizer.for(:sign_up) { 
	        |u| u.permit(registration_params) 
	      }
	    end
	end

	private
		def current_user
		  @current_user ||= User.find(session[:user_id]) if session[:user_id]
		 end	 
end
