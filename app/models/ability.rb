# frozen_string_literal: true

class Ability
  include CanCan::Ability

      def initialize(customer)
        #customer ||= Customer.new
        #if customer.admin?
        #  can :manage, Room
        #else
        #  can :manage, Room, customer_id: customer.id
        #  can :read, Room
        #can :read, Room, published: true

        #return unless user.present?

        #can [:read, :update], Room, user: user

        #return unless user.admin?

        #can :manage, Room
      #end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end