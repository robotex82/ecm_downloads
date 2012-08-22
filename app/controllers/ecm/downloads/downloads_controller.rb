class Ecm::Downloads::DownloadsController < FrontendController
  def index
    @downloads = Ecm::Downloads::Download.published.all
  end

  def show
    @download = Ecm::Downloads::Download.published.find(params[:id])
  end
end
