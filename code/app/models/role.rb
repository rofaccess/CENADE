class Role < ActiveRecord::Base
  paginates_per 20

  #Asociaciones
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :permissions
  belongs_to :resource,
             :polymorphic => true

  scopify

  #Validaciones
  validates :name, presence: true, length: { in: 3..Domain::ROL }, uniqueness: true
  #validates :permission_ids, presence: true # //- No permite correr el seed

  #Callbacks
  before_destroy :can_destroy?

  def can_destroy?
    # No deja borrar si el rol esta relacionado a algun usuario
    if users.present?
      errors.add(:base, I18n.t('activerecord.errors.messages.restrict_dependent_destroy.many', record: 'usuarios'))
      false
    end
  end
end
