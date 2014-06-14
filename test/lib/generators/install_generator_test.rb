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

  end
end