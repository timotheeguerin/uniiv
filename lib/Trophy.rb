require 'trophy/controller_extensions'

module Trophy
  # Load configuration from initializer
  def self.setup
    yield self
  end

  class Engine < Rails::Engine
    initializer 'trophy.controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        begin
          ::Trophy::BadgeRule = ::Trophy::BadgeRules.new.defined_rules
          include Trophy::ControllerExtensions
        end
      end
    end
  end
end