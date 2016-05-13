class Ability
  include CanCan::Ability



  def initialize(user)

    if user
      User.find(user).roles.first.permissions.each do |permission|

          can :manage, permission.model.singularize.classify.constantize
      end
    end
  end

end