module Slouch
  module Generators
    module Helper
      extend ActiveSupport::Concern

      module InstanceMethods
        protected

        def backbone_collection_name
          name.pluralize.camelize
        end

        def backbone_model_name
          name.camelize
        end

        def collection_restful_url
          name.pluralize
        end

        def generator_rails_options
          Rails.application.config.generators.options[:rails]
        end

        def application_name
          Rails.application.class.to_s.split("::").first
        end
      end

    end
  end
end

