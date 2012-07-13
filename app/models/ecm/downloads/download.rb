class Ecm::Downloads::Download < ActiveRecord::Base
  # db settings
  self.table_name = 'ecm_downloads_downloads'
  
  # acts as list
  acts_as_list :scope => :ecm_downloads_download_category  
  
  # associations
  belongs_to :ecm_downloads_download_category, 
             :class_name => Ecm::Downloads::DownloadCategory, 
             :counter_cache => :ecm_downloads_downloads_count
  
  # attibutes
  attr_accessible :description, 
                  :locale, 
                  :name
                  
  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  # paperclip
  has_attached_file :asset
  
  # validations 
  validates :ecm_downloads_download_category, :presence => true
  validates :locale, :inclusion => { :in => I18n.available_locales.map(&:to_s) }, :unless => Proc.new { |c| c.locale.blank? }
  validates :name, :presence => true  
  validates_attachment_presence :asset
end
