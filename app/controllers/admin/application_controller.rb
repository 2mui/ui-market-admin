# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Administrate::Punditize
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action :authenticate_user!
    before_action :authenticate_admins

    # def default_url_options
    #   {
    #     :locale => I18n.locale,
    #     :host => "localhost"
    #   }
    # end

    def authenticate_admins
      # TODO Add authentication logic here.
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    private
      # only allow role: [:admin, :editor] can login
      def access_whitelist
        current_user.try(:admin?) || current_user.try(:editor?) || current_user.try(:door_super?)
      end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
