module Trophy
  class Rule
    attr_accessor :badge_name, :temporary, :block

    # Does this rule's condition block apply?
    def applies?(target_obj = nil)
      return true if block.nil? #if the block is not specified then condition is completed

      case block.arity
        when 1 # Expects target object
          if target_obj.present?
            block.call(target_obj)
          else
            Rails.logger.warn '[trophy2] no target_obj found on Rule#applies?'
            false
          end
        else
          block.call
      end
    end

    # Get rule's related Badge.
    def badge
      @badge ||= Badge.find_by_name(badge_name)
    end
  end
end