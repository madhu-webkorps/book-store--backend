# frozen_string_literal: true

class Ability
  
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    
      # return unless user.present?
      if user.present?
       
          if user.admin?
            can :manage, Book 
            can :manage , User
            can %i[read], Issuedbook
          end

          if user.user?
            
            can %i[read], Book
            can %i[profile], User, user: user
            can %i[read create return], Issuedbook, user: user
          end

      end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end

end
