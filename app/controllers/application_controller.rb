class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  unless Rails.application.config.consider_all_requests_local             
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end
  before_action :set_locale
  include SessionsHelper
  include ApplicationHelper


def not_found
  raise ActionController::RoutingError.new('Not Found')
end

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash_message :danger ,  "Please log in."
        redirect_to login_url
      end
    end

    def set_locale 
      I18n.locale = params[:locale] || I18n.default_locale
      # current_user.locale
      # request.env["HTTP_ACCEPT_LANGUAGE"]
    end

    def default_url_options (options = {})
      { locale: I18n.locale }.merge options
    end


    
  end
