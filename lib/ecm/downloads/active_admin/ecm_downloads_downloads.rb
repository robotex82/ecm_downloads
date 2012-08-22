include ActiveAdmin::ActsAsList::Helper
include ActsAsPublished::ActiveAdminHelper

ActiveAdmin.register Ecm::Downloads::Download do
  # acts as list
  sortable_member_actions

  # acts as published
  acts_as_published_actions

  # config
  menu :parent => I18n.t('ecm.downloads.active_admin.menu')

  # scopes
  scope :all
  scope :published
  scope :unpublished

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :ecm_downloads_download_category, :as => :select,
                                                :collection => nested_set_options(Ecm::Downloads::DownloadCategory) { |dc| "#{'-' * dc.level} #{dc.name}" }
      f.input :asset, :as => :file
      f.input :name
      f.input :published, :as => :boolean
      f.input :description
    end

    f.actions
  end

  index do
    selectable_column
    column :ecm_downloads_download_category
    column :name
    acts_as_published_columns
    column :asset_file_name
    column :asset_file_size, :sortable => :asset_file_size do |download|
      number_to_human_size(download.asset_file_size)
    end
    column :created_at
    default_actions
  end
end if defined?(ActiveAdmin)
