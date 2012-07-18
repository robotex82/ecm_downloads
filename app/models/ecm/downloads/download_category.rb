class Ecm::Downloads::DownloadCategory < ActiveRecord::Base
  # db settings
  self.table_name = 'ecm_downloads_download_categories'
  
  # associations
  has_many :ecm_downloads_downloads, 
           :class_name => Ecm::Downloads::Download, 
           :dependent => :destroy,
           :foreign_key => :ecm_downloads_download_category_id,
           :order => 'position'
  
  # attributes
  attr_accessible :description, 
                  :ecm_courses_courses_count, 
                  :locale, 
                  :name, 
                  :parent_id, 
                  :position, 
                  :slug
                  
  # awesome nested set
  acts_as_nested_set
  default_scope :order => 'lft ASC'
  
  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged
                    
  # validations
  validates :name, :presence => true, :uniqueness => { :scope => [ :parent_id ] }
  validates :locale, :presence => true, :if => :root?
  validates :locale, :inclusion => { :in => I18n.available_locales.map(&:to_s) }, :unless => Proc.new { |cc| cc.locale.blank? }
  validates :locale, :absence => true, :unless => :root? 
  
  # public methods
  
  # public methods
  def index_name
    if self.root?
      "[#{self.locale}] #{self.name}"
    else
      "#{'&#160;&#160;&#160;&#160;' * self.level} |--&#160;#{self.name}".html_safe
    end  
  end
  
  def to_s
    name
  end
  
  def tree_name
    if ecm_downloads_downloads_count < 1
      "#{to_s}" 
    else 
      "#{to_s} (#{ecm_downloads_downloads_count})"     
    end
  end 
end
