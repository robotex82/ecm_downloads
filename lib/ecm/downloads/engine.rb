module Ecm
  module Downloads
    class Engine < Rails::Engine
     #  endpoint 
      
      # active admin
      initializer :ecm_courses_engine do
        ::ActiveAdmin.setup do |active_admin_config|
          active_admin_config.load_paths += Dir[File.dirname(__FILE__) + '/../../../app/admin']
        end
      end if defined?(::ActiveAdmin)
      
      # controllers
      # paths["app/controllers"] << File.dirname(__FILE__) + '/../../../app/controllers'
      
      # helpers
      config.to_prepare do
        ApplicationController.helper(Ecm::Downloads::DownloadCategoryHelper)
      end 
      
      # locales
      paths["config/locales"] << File.dirname(__FILE__) + '/../../../config/locales'
    end
  end
end    
