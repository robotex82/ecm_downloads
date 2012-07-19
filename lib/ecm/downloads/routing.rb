module Ecm
  module Downloads
    class Routing
      # Creates the routes for downloads and categories. You can pass options to
      # specify the actions for both downloads and/or categories.
      #
      #   Ecm::Downloads::Routing.routes(self, { :download_category_actions => [ :show ]})
      #
      # This will only create the show action for download categories, but omit the index action.
      def self.routes(router, options = {})
        options.reverse_merge!(
          { :download_category_actions => [:index, :show], 
            :download_actions => [:index, :show] 
          }
        )
        
        router.resources :ecm_downloads_download_categories, :only => options[:download_category_actions], :controller => 'ecm/downloads/download_categories'
        router.resources :ecm_downloads_downloads,:only => options[:download_actions], :controller => 'ecm/downloads/downloads'      
      end  
    end
  end
end    
