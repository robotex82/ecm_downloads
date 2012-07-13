# This migration comes from ecm_downloads_engine (originally 1)
class CreateEcmDownloadsDownloadCategories < ActiveRecord::Migration
  def change
    create_table :ecm_downloads_download_categories do |t|
      t.string :name
      t.text :description
      t.string :locale
      t.integer :position
      
      # references
      t.integer :ecm_downloads_downloads_count, :default => 0, :null => false
      
      # awesome nested set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      
      # frienldy id
      t.string :slug

      t.timestamps
    end
  end
end
