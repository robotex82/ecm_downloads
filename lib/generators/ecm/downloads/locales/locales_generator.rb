module Ecm
  module Downloads
    module Generators
      class LocalesGenerator < Rails::Generators::Base
        desc "Copies the locale files to your application"

        source_root File.expand_path('../../../../../../config/locales', __FILE__)

        def generate_locales
          copy_file "ecm.downloads.en.yml", "config/locales/ecm.downloads.en.yml"
          copy_file "ecm.downloads.de.yml", "config/locales/ecm.downloads.de.yml"

          copy_file "ecm.downloads.download_category.en.yml", "config/locales/ecm.downloads.download_category.en.yml"
          copy_file "ecm.downloads.download_category.de.yml", "config/locales/ecm.downloads.download_category.de.yml"


          copy_file "ecm.downloads.download.en.yml", "config/locales/ecm.downloads.download.en.yml"
          copy_file "ecm.downloads.download.de.yml", "config/locales/ecm.downloads.download.de.yml"
        end
      end
    end
  end
end

