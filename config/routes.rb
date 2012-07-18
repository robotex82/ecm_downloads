Rails.application.routes.draw do
#  resources :ecm_downloads_download_categories, :only => [ :index, :show ], :controller => 'abc/downloads/download_categories'
#  resources :ecm_downloads_downloads, :only => [ :index, :show ], :controller => 'abc/downloads/downloads'
  resources :ecm_downloads_download_categories, :only => [ :index, :show ], :controller => 'ecm/downloads/download_categories'
  resources :ecm_downloads_downloads, :only => [ :index, :show ], :controller => 'ecm/downloads/downloads'
end  
