module Ecm::Downloads::DownloadCategoryHelper
  def render_download_category(download_category_name, options = {})
    download_category = ::Ecm::Downloads::DownloadCategory.where(:name => download_category_name).first
    if download_category.nil?
      I18n.t('ecm.downloads.download_category.messages.not_found', :name => download_category_name)
    else
      render download_category
    end
  end
end
