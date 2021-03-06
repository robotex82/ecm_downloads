module FixUpdateCounters
  def fix_updated_counters
    self.changes.each {|key, value|
      # key should match /master_files_id/ or /bibls_id/
      # value should be an array ['old value', 'new value']
      if key =~ /_id/
        changed_class = key.sub(/_id/, '')

        # Get real class of changed attribute, so work both with namespaced/normal models
        klass = self.association(changed_class.to_sym).klass

        # Try to get counter cache from association options
        begin
           counter_name = self.association(changed_class.to_sym).options[:counter_cache]
        rescue
          # Namespaced model return a slash, split it.
          unless (counter_name = "#{self.class.name.underscore.pluralize.split("/")[1]}_count".to_sym)
            counter_name = "#{self.class.name.underscore.pluralize}_count".to_sym
          end
        end


        klass.decrement_counter(counter_name, value[0]) unless value[0] == nil
        klass.increment_counter(counter_name, value[1]) unless value[1] == nil
      end
    }
  end
end

ActiveRecord::Base.send(:include, FixUpdateCounters)



class Ecm::Downloads::Download < ActiveRecord::Base
  # db settings
  self.table_name = 'ecm_downloads_downloads'

  # acts as list
  acts_as_list :scope => :ecm_downloads_download_category

  # acts as published
  include ActsAsPublished::ActiveRecord
  acts_as_published

  # associations
  belongs_to :ecm_downloads_download_category,
             :class_name => Ecm::Downloads::DownloadCategory,
             :counter_cache => :ecm_downloads_downloads_count

  # attibutes
  attr_accessible :asset,
                  :description,
                  :ecm_downloads_download_category_id,
                  :name

  # callbacks
  after_update :fix_updated_counters
  before_update :fix_updated_position, :if => Proc.new { |d| !position.blank? && d.ecm_downloads_download_category_id_changed? }

  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged

  # paperclip
  has_attached_file :asset, Ecm::Downloads::Configuration.paperclip_options

  # validations
  validates :ecm_downloads_download_category, :presence => true
  validates :name, :presence => true
  validates_attachment_presence :asset

  # public methods

  def to_s
    name
  end

  # private methods
  private
  def fix_updated_position
    Rails.logger.debug "Fixing positions for #{self.to_s} (Moving to last)"
    add_to_list_bottom
  end
end
