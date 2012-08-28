class Ecm::Downloads::DownloadCategory < ActiveRecord::Base
  # db settings
  self.table_name = 'ecm_downloads_download_categories'

  # associations
  has_many :ecm_downloads_downloads,
           :class_name => Ecm::Downloads::Download,
           :dependent => :destroy,
           :foreign_key => :ecm_downloads_download_category_id,
           :order => 'position'

  accepts_nested_attributes_for :ecm_downloads_downloads,
                                :allow_destroy => true

  # attributes
  attr_accessible :description,
                  :ecm_downloads_downloads_attributes,
                  :ecm_downloads_downloads_count,
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
  validates :name, :presence => true, 
                   :uniqueness => { :scope => [ :parent_id ] }
                   
  validates :locale, :presence => true, 
                     :if => :root?
                     
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s), 
                     :if => Proc.new { |cc| cc.locale.present? }
                     
  validates :locale, :absence => true, 
                     :unless => :root?

  # public methods

  # public methods

  def display_code
    "<%= render_download_category '#{self.name}' %>"
  end

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
    root_prefix = (self.root?) ? "[#{self.locale}] " : ""

    if ecm_downloads_downloads_count < 1
      "#{root_prefix}#{to_s}"
    else
      "#{root_prefix}#{to_s} (#{ecm_downloads_downloads_count})"
    end
  end
end
