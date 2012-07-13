FactoryGirl.define do
  factory :ecm_downloads_download_category, :class => Ecm::Downloads::DownloadCategory do
    name "User guides"
    locale I18n.default_locale.to_s
      
    factory :ecm_downloads_download_category_with_parent do
      locale nil
      association :parent, :factory => :ecm_downloads_download_category
    end
  end
end
