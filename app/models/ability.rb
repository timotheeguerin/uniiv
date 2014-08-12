class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    #can :manage, :all
    if user.role? :alpha_tester
      can :read, :all # allow alpha tester to read everything
      can :edit, user
    end

    if user.role? :user
      can :read, :all # allow user to read everything
      can :view, :all
      can :edit, user

      cannot :view, User::Invite

      # Issue::Issue
      cannot :read, [Issue::Issue, User::AdvisorStudent]
      can [:create, :read, :update, :destroy], Issue::Issue, reporter_id: user.id
      can [:create, :read, :update, :destroy], Issue::Issue, assignee_id: user.id
      can :change_status, Issue::Issue, assignee_id: user.id

      can :manage, Issue::Comment, issue: {reporter_id: user.id}
      can :manage, Issue::Comment, issue: {assignee_id: user.id}

      can [:read, :create, :update, :destroy], User::AdvisorStudent, student_id: user.id
    end

    if user.role? :advisor
      can :sign_in_as, User.only_with_roles([:user])
      can :validate, user.advisor_students
      can :update_status, user.advisor_students
      can :manage, User::AdvisorStudent, advisor_id: user.id

    else
      cannot :view, :advisor_dashboard
    end

    if user.role? :admin
      can :manage, :all
    end
  end
end
