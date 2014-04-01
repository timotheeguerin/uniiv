require 'rails/generators'
require 'generators/uniiv/generator_helper'

module Uniiv
  class InstallGenerator < Rails::Generators::Base
    include Uniiv::GeneratorHelper
    source_root File.expand_path('../templates', __FILE__)
    desc 'Install local config file'

    argument :_username, type: :string, required: false, desc: 'Database username'
    argument :_password, type: :string, required: false, desc: 'Database password'
    argument :_username_main, type: :string, required: false, desc: 'Main database username'
    argument :_password_main, type: :string, required: false, desc: 'Main database password'

    def install
      username = ask_for('Database username?', 'root', _username)
      password = ask_for('Database password?', '', _password)
      username_main = ask_for('Main database username?', 'root', _username_main)
      password_main = ask_for('Main database password?', '', _password_main)
      template 'local_env_initializer.yml.erb', 'config/local/local_env.yml',
               :username => username, :password => password,
               :username_main => username_main, :password_main => password_main
    end
  end
end