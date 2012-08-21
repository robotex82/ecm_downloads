if defined?(ActiveAdmin)
  include ActiveAdmin::ActsAsList::Helper
  
  ActiveAdmin.register Ecm::Downloads::Download do
    # acts as list
    sortable_member_actions
    
    # config
    menu :parent => I18n.t('ecm.downloads.active_admin.menu')
    
    form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs do
        f.input :ecm_downloads_download_category, :as => :select, 
                                                  :collection => nested_set_options(Ecm::Downloads::DownloadCategory) { |dc| "#{'-' * dc.level} #{dc.name}" }
        f.input :locale, :as => :select, 
                         :collection => I18n.available_locales.map(&:to_s)
        f.input :asset, :as => :file
        f.input :name
        f.input :description
      end
      
      f.actions
    end
    
    index do
      selectable_column
      column :locale      
      column :ecm_downloads_download_category
      column :name
      column :asset_file_name
      column :asset_file_size, :sortable => :asset_file_size do |download|
        number_to_human_size(download.asset_file_size)
      end
      column :created_at
      default_actions
    end
  end
end  
