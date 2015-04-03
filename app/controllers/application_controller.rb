class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_no_cache
  before_filter :stylesheet_filename, :javascript_filename, :set_default_title, :current_user

  include ApplicationHelper
  include AuthenticationHelper
  include NotificationHelper

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "#{1.year.ago}"
  end

  private

  def set_default_title
    set_title("Anser and get a goodie. Ruby India Conference - 2015")
  end

  def stylesheet_filename
    @stylesheet_filename = "admin"
  end

  def javascript_filename
    @javascript_filename = "admin"
  end

end
