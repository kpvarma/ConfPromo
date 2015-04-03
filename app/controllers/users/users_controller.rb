module Users
  class UsersController < Poodle::AdminController

    skip_before_filter :require_admin

    def create
      @user = User.new
      @user.assign_attributes(permitted_params)
      @user.assign_default_password_if_nil
      save_resource(@user)
    end

    def resource_url(obj)
      url_for([:users, obj])
    end

    private

    def get_collections
      # Fetching the users
      relation = User.where("")
      @filters = {}
      if params[:query]
        @query = params[:query].strip
        relation = relation.search(@query) if !@query.blank?
      end

      @per_page = params[:per_page] || "20"
      @users = relation.order("created_at desc").page(@current_page).per(@per_page)

      ## Initializing the @user object so that we can render the show partial
      @user = @users.first unless @user

      return true
    end

    def permitted_params
      params[:user].permit(:name, :email)
    end

  end
end
