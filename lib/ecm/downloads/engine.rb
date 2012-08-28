module Ecm
  module Downloads
    class Engine < Rails::Engine 
      # active admin
      initializer :ecm_courses_engine do
        ::ActiveAdmin.setup do |active_admin_config|
          active_admin_config.load_paths += Dir[File.dirname(__FILE__) + '/active_admin']
        end
      end if defined?(::ActiveAdmin)
      
      # helpers
      config.to_prepare do
        ApplicationController.helper(Ecm::Downloads::DownloadCategoryHelper)
        ApplicationController.helper(Ecm::Downloads::DownloadHelper)
      end 
      
      # locales
      paths["config/locales"] << File.dirname(__FILE__) + '/../../../config/locales'
    end
  end
end    
