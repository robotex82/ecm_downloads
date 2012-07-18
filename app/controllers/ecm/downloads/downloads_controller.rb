class Ecm::Downloads::DownloadsController < FrontendController
  def index
    @downloads = Ecm::Downloads::Download.all
  end
  
  def show
    @download = Ecm::Downloads::Download.find(params[:id])  
  end
end
