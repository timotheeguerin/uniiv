require 'rails/generators'
require 'generators/uniiv/generator_helper'

module Uniiv
  class SecretGenerator < Rails::Generators::Base
    include Uniiv::GeneratorHelper
    source_root File.expand_path('../templates', __FILE__)
    desc 'Install local config file'

    def secret
      token = Enumerator.new do |yielder|
        loop do
          yielder.yield SecureRandom.hex(64)
        end
      end
      template 'secrets.yml.erb', 'config/secrets.yml', :token => token
    end
  end
end