# This migration comes from ecm_downloads_engine (originally 2)
class CreateEcmDownloadsDownloads < ActiveRecord::Migration
  def change
    create_table :ecm_downloads_downloads do |t|
      t.string :name
      t.text :description
      t.timestamp :published_at

      # references
      t.references :ecm_downloads_download_category

      # acts as list
      t.integer :position

      # friendly id
      t.string :slug

      # paperclip
      # t.attachment :asset
      t.string :asset_file_name
      t.integer :asset_file_size
      t.string :asset_content_type
      t.timestamp :asset_updated_at
      t.string :asset_fingerprint

      t.timestamps
    end
    add_index :ecm_downloads_downloads,
              :ecm_downloads_download_category_id,
              :name => 'index_ecm_downloads_downloads_on_download_category_id'
  end
end
