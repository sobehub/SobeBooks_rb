class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #include DevisePermittedParameters

  protect_from_forgery with: :exception 
  before_action :authenticate_user!, :except => [:public_app] #if params[:controller]!= "public"

  def formatted_date(current_date)
    date = current_date.split('-')
    # Convert MM-DD-YYYY to YYYY-MM-DD
    DateTime.parse(date[2] + '-' + date[0] + '-' + date[1]) rescue ''
  end
end
