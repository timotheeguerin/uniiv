require 'rails/generators'
require 'generators/uniiv/generator_helper'

module Uniiv
  class InstallGenerator < Rails::Generators::Base
    include Uniiv::GeneratorHelper
    source_root File.expand_path('../templates', __FILE__)
    desc 'Install local config file'

    argument :_username, type: :string, required: false, desc: 'Database username'
    argument :_password, type: :string, required: false, desc: 'Database password'

    def install
      username = ask_for('Database username?', 'root', _username)
      password = ask_for('Database password?', '', _password)
      template 'local_env_initializer.yml.erb', 'config/local/local_env.yml', :username => username, :password => password
    end
  end
end