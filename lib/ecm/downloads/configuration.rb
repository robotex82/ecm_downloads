require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Ecm
  module Downloads
    module Configuration
      def configure
        yield self
      end # def

       mattr_accessor :paperclip_options
       @@paperclip_options = {}
    end # module Configuration
  end # module Downloads
end # module Ecm

