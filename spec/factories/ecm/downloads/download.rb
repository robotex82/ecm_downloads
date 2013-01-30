FactoryGirl.define do
  factory :ecm_downloads_download, :class => Ecm::Downloads::Download do
    sequence(:name) { |i| "Download ##{i}" }
    ecm_downloads_download_category
    asset { File.open(File.join(Rails.root, "spec/files", "ecm/downloads", "download/asset.txt")) }
  end
end

