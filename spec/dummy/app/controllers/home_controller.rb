class HomeController < ApplicationController
  def index
    @ecm_downloads_download_category = Ecm::Downloads::DownloadCategory.first
    @ecm_downloads_download = Ecm::Downloads::Download.first    
  end
end  
