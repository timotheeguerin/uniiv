require 'rails/generators'
require 'generators/uniiv/generator_helper'

module Uniiv
  class InstallGenerator < Rails::Generators::Base
    include Uniiv::GeneratorHelper
    source_root File.expand_path('../templates', __FILE__)
    desc 'Install local config file'

    def install
      config = {
          :local_username => 'root', :local_password => '',
          :uniiv_dev_username => 'readonly', :uniiv_dev_password => '', :uniiv_dev_host => '',
          :uniiv_prod_username => 'readonly', :uniiv_prod_password => '', :uniiv_prod_host => ''
      }
      config.each do |k, v|
        config[k] = ask_for(k.to_s.humanize, v)
      end
      template 'local_env_initializer.yml.erb', 'config/local/local_env.yml', config
    end
  end
end