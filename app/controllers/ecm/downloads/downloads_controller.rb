class Ecm::Downloads::DownloadsController < FrontendController
  # Support secured downloads with expiring urls on S3.
  def download
    @download = Ecm::Downloads::Download.published.find(params[:id])
    redirect_to @download.asset.expiring_url(100)
  end

  def index
    @downloads = Ecm::Downloads::Download.published.all
  end

  def show
    @download = Ecm::Downloads::Download.published.find(params[:id])
  end
end
