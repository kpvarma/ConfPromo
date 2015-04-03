class AuthenticationService

  attr_reader :email, :password, :error, :user

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
    @error = nil

    check_if_user_exists
    if @user
      authenticate
      # check_if_user_is_active
    end
  end

  def invalid_login_error
    "authentication.invalid_login"
  end

  def user_status_error
    "authentication.user_is_#{@user.status.downcase}"
  end

  def check_if_user_exists
    @user = User.where("LOWER(email) = LOWER('#{@email}')").first
    set_error(invalid_login_error) unless @user
  end

  def check_if_user_is_active
    set_error(user_status_error) unless @user.active?
  end

  def authenticate
    set_error(invalid_login_error) unless @user.authenticate(@password)
  end

  def set_error(id)
    @error ||= id
  end
end