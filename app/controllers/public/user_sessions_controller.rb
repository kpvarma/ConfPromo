module Public
  class UserSessionsController < ApplicationController

    layout 'poodle/public'
    before_filter :require_user, :only => :sign_out
    before_filter :redirect_to_dashboard, :only => [:sign_in, :create_session]

    def sign_in
    end

    def create_session
      @registration_details = AuthenticationService.new(params)
      if @registration_details.error
        set_notification_messages(@registration_details.error, :error)
        redirect_or_popup_to_default_sign_in_page
        return
      else
        @user = @registration_details.user
        session[:id] = @user.id
        @current_user = @user
        set_notification_messages("authentication.logged_in", :success)
        redirect_to_appropriate_page_after_sign_in
        return
      end
    end

    def sign_out
      set_notification_messages("authentication.logged_out", :success)
      # Reseting the auth token for user when he logs out.
      @current_user = nil
      session.delete(:id)
      restore_last_user
      redirect_after_unsuccessful_authentication
    end

    private

    def redirect_to_dashboard
      redirect_to_appropriate_page_after_sign_in if @current_user
    end

  end
end