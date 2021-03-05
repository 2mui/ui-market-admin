module Admin
  class ItemsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    # def permitted_attributes
    #   super << :filetype
    # end

    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes << :filetype).
    #     transform_values { |v| read_param_value(v) }
    # end

    def toggle_featured
      puts 'toggle_featured'
      requested_resource.featured = !requested_resource.featured
      if requested_resource.save
        redirect_to(
          [namespace, requested_resource.class],
          notice: translate_with_resource("update.success"),
        )
      end
    end

    def toggle_draft
      puts 'toggle_draft'
      requested_resource.draft = !requested_resource.draft
      if requested_resource.save
        redirect_to(
          [namespace, requested_resource.class],
          notice: translate_with_resource("update.success"),
        )
      end
    end

    def create
      resource = resource_class.new(resource_params)

      # set upload_by field
      resource.upload_by = current_user.id

      authorize_resource(resource)

      if resource.save
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def default_sorting_attribute
      :updated_at
    end

    def default_sorting_direction
      :desc
    end

    # https://api.rubyonrails.org/v4.1.8/classes/ActionController/Parameters.html
    # 必须要 permit(filetype: []).
    def resource_params
      params.require(resource_class.model_name.param_key).
        permit(dashboard.permitted_attributes << {filetype: []}).
        transform_values { |v| read_param_value(v) }
    end
  end
end
