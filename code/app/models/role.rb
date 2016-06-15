class Role < ActiveRecord::Base
  paginates_per 20
  has_and_belongs_to_many :users, :join_table => :users_roles, dependent: :restrict_with_error
  has_and_belongs_to_many :permissions
  belongs_to :resource,
             :polymorphic => true

  scopify

  before_destroy :can_destroy?

  def can_destroy?
    # No deja borrar si el rol esta relacionado a algun usuario
    if users.present?
      errors.add(:base, I18n.t('activerecord.errors.messages.restrict_dependent_destroy.many', record: 'usuarios'))
      false
    end
  end
end
