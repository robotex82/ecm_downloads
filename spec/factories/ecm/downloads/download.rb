FactoryGirl.define do
  factory :ecm_downloads_download, :class => Ecm::Downloads::Download do
    # name "#{Faker::Product.product} training"
    name "Rails user guide"
    ecm_downloads_download_category
    asset { fixture_file_upload(Rails.root + "spec/fixtures/test.jpg", "image/jpg") }
  end
end
