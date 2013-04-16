require "outpost/publishing/version"
require "outpost/publishing/association"
require "outpost/publishing/acts_as_alarm"

module Outpost
  module Publishing
    mattr_accessor :status_published
    @@status_published = 5

    class Engine < ::Rails::Engine
    end
  end
end

