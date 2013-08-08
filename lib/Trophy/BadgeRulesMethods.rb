module Trophy
  module BadgeRulesMethods
    # Define rule for granting badges
    #actions: List of all the actions to listen to
    #args: arguments
    #block: condition for giving the badge
    def grant_on(actions, *args, &block)
      options = args.extract_options!

      actions = Array.wrap(actions)

      rule = Rule.new
      rule.badge_name = options[:badge]
      rule.temporary = options.fetch(:temporary, true)
      rule.block = block

      actions.each do |action|
        defined_rules[action] ||= []
        defined_rules[action] << rule
      end
    end

    # All currently defined rules
    def defined_rules
      @defined_rules ||= {}
    end
  end
end