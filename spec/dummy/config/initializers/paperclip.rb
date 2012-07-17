if defined?(Paperclip)
  module Paperclip
    class << Attachment
    
      alias :original_default_options :default_options
      
      def default_options
        return @default_options if @default_options
        @default_options = original_default_options
        if defined?(Rails.root) and File.exists?("#{Rails.root}/config/paperclip.yml") 
          @default_options.merge!(YAML.load_file("#{Rails.root}/config/paperclip.yml")[Rails.env].symbolize_keys)
        end
      @default_options
      end
    end
  end
end  
