require 'test_helper'
require 'rails/generators'
require 'generators/uniiv/install_generator'


class InstallGeneratorTest < Rails::Generators::TestCase
  tests Uniiv::InstallGenerator
  destination File.expand_path('../../tmp', __FILE__)

  setup do
    prepare_destination
  end

  test 'Assert local env file exists and contains the right values' do
    run_generator ['test_user', 'test_password', 'test_user_main', 'test_password_main']
    assert_file 'config/local/local_env.yml', /test_user/
    assert_file 'config/local/local_env.yml', /test_password/
    assert_file 'config/local/local_env.yml', /test_user_main/
    assert_file 'config/local/local_env.yml', /test_password_main/
  end
end