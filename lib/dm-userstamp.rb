require 'rubygems'

gem 'dm-core', '=0.9.4'
require 'dm-core'

module DataMapper
  module Userstamp
    USERSTAMP_PROPERTIES = {
      :created_by_id => lambda { |r| r.created_by_id = User.current_user.id if User.current_user && r.new_record? && r.created_by_id.nil? },
      :updated_by_id => lambda { |r| r.updated_by_id = User.current_user.id if User.current_user}
    }

    def self.included(model)
      model.before :save, :set_userstamp_properties
    end

    private

    def set_userstamp_properties
      self.class.properties.slice(*USERSTAMP_PROPERTIES.keys).compact.each do |property|
        USERSTAMP_PROPERTIES[property.name][self]
      end
    end
  end
  
  Resource::append_inclusions Userstamp
end