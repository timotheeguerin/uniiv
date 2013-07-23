require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminParseCourseExpr
end

module RailsAdmin
  module Config
    module Actions
      class ParseCourseExpr < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          bindings[:abstract_model].model.to_s == 'CourseExpr'
        end
        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end
        register_instance_option :link_icon do
          'icon-check'
        end
        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do

          Proc.new do
            @response = {}

            if request.post?
              input = params['file']
              expr = CourseExpr.parse(input)
              render :action => @action.template_name if expr.nil?
              expr.save()
              #results = @abstract_model.model.run_import(params)
              redirect_to back_or_index

            else
              render :action => @action.template_name
            end
          end
        end

        register_instance_option :link_icon do
          'icon-pencil'
        end
      end
    end
  end
end