if defined?(ActiveAdmin)
  include ActiveAdmin::ActsAsList::Helper
  include ActiveAdmin::AwesomeNestedSet::Helper
  
  ActiveAdmin.register Ecm::Downloads::DownloadCategory do
    # menu entry settings
    menu :parent => I18n.t('ecm.downloads.active_admin.menu')
    
    # sorting
    config.sort_order = 'lft_asc'
    
    # awesome nested set
    sortable_tree_member_actions
    
    form do |f|
      f.inputs do
        f.input :parent, :as => :select, :collection => nested_set_options(Ecm::Downloads::DownloadCategory, f.object) { |dc| "#{'-' * dc.level} #{dc.name}" }
        f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
        f.input :name
        f.input :description
      end
      
      f.actions
    end
    
    index do
      selectable_column
      sortable_tree_columns
      column :index_name      
#      column :locale
#      column :parent
#      column :name
      column :description
      column :ecm_downloads_downloads_count
      default_actions
    end
    
    show :title => :to_s do
      attributes_table do
        row :parent
        row :locale
        row :name
        row :ecm_downloads_downloads_count
        row :created_at
        row :updated_at
      end
      
      panel Ecm::Downloads::DownloadCategory.human_attribute_name(:description) do
        div do
          ecm_downloads_download_category.description
        end
      end
      
      panel Ecm::Downloads::DownloadCategory.human_attribute_name(:children) do
        table_for ecm_downloads_download_category.children, :i18n => Ecm::Downloads::DownloadCategory do
#          column(:name) { |ecm_downloads_download| link_to ecm_downloads_download, [:admin, ecm_downloads_download] }
          sortable_tree_columns
          column(:index_name) { |ecm_downloads_download_category| link_to ecm_downloads_download_category, [:admin, ecm_downloads_download_category] }  
    #      column :locale
    #      column :parent
    #      column :name
          column :description
          column :ecm_downloads_downloads_count
        end
      end        
      
      panel Ecm::Downloads::DownloadCategory.human_attribute_name(:ecm_downloads_downloads) do
        table_for ecm_downloads_download_category.ecm_downloads_downloads, :i18n => Ecm::Downloads::Download do
          sortable_columns
          column :position
          column :locale      
          column(:name) { |ecm_downloads_download| link_to ecm_downloads_download, [:admin, ecm_downloads_download] }
          column :asset_file_name
          column :asset_file_size, :sortable => :asset_file_size do |download|
            number_to_human_size(download.asset_file_size)
          end
          column :created_at          
        end
      end              
    end
  end
end  
