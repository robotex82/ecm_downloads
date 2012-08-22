namespace :ecm_downloads do
  namespace :db do
    desc "Purges and creates example data"
    task :populate!, [] => [:environment] do |t, args|

      Rake::Task["ecm_downloads:db:clear!"].execute
      Rake::Task["ecm_downloads:db:populate"].execute
    end

    desc "Clears all data!"
    task :clear!, [] => [:environment] do |t, args|
      Ecm::Downloads::DownloadCategory.delete_all
      Ecm::Downloads::Download.delete_all
    end

    desc "Creates example_data"
    task :populate, [] => [:environment] do |t, args|
      require "ffaker"
      require "forgery"

      # Create example download category roots
      10.times do
        Ecm::Downloads::DownloadCategory.create! do |dc|
          dc.locale            = I18n.available_locales.choice.to_s
          dc.name              = Faker::Product.brand
          dc.description       = Faker::Lorem.paragraph(rand(10))
        end
      end

      # Create example download sub-categories
      10.times do
        Ecm::Downloads::DownloadCategory.create! do |dc|
          dc.parent            = Ecm::Downloads::DownloadCategory.all.choice
          dc.name              = Faker::Product.brand
          dc.description = Faker::Lorem.paragraph(rand(10))
        end
      end

      # Create example downloads
      download_categories = Ecm::Downloads::DownloadCategory.all
      100.times do
        Ecm::Downloads::Download.create! do |d|
          d.ecm_downloads_download_category = download_categories.choice
          d.name        = Faker::Product.product_name
          d.asset       = File.open(Ecm::Downloads::Engine.root + "spec/fixtures/download/example.txt")
          d.published   = [true, false].choice
          d.description = Faker::Lorem.paragraph(rand(10))
        end
      end
    end
  end
end
