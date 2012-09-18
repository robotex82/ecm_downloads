require 'rubygems'

require 'active_admin-acts_as_list'
require 'active_admin-awesome_nested_set'
require 'acts_as_list'
require 'acts_as_published'
require 'awesome_nested_set'
require 'awesome_nested_set-tools'
require 'friendly_id'
require 'rails_tools-absence_validator'
require 'paperclip'

require 'ecm/downloads/engine'
require 'ecm/downloads/configuration'
require 'ecm/downloads/routing'

module Ecm
  module Downloads
    extend Configuration
  end
end

