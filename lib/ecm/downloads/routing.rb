module Ecm
  module Downloads
    class Routing
      def self.routes(router)
        router.resources :ecm_downloads_download_categories, :only => [ :index, :show ], :controller => 'ecm/downloads/download_categories'
        router.resources :ecm_downloads_downloads, :only => [ :index, :show ], :controller => 'ecm/downloads/downloads'      
      end  
    end
  end
end    
