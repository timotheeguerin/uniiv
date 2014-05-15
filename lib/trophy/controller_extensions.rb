module Trophy
  module ControllerExtensions
    def self.included(base)
      base.after_filer do |controller|
        puts 'Check achivement'
      end
    end
  end
end