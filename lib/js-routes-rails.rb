require 'js-routes/rails'

module Js
  module Routes
    def self.root
      File.expand_path('../..', __FILE__)
    end
  end
end
