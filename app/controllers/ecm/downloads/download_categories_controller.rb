class Ecm::Downloads::DownloadCategoriesController < FrontendController
  def index
    @download_categories = Ecm::Downloads::DownloadCategory.all
  end
  
  def show
    @download_category = Ecm::Downloads::DownloadCategory.find(params[:id])
  end
end
