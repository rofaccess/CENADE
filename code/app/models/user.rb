class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :profile_foto, ProfileFotoUploader
  paginates_per 20

  devise :database_authenticatable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  #Asociaciones
  belongs_to :empleado, -> { with_deleted }
  has_many :consultas
  has_and_belongs_to_many :roles, :join_table => :users_roles

  #Validaciones
  validates :username, presence: true, length: { in: 3..Domain::USERNAME }, uniqueness: true
  validates :empleado, presence: true
  #validates :role_ids, presence: true #Para validar multiples roles

	def email_required?
   	false
	end

  def get_role
    role = Role.joins("LEFT JOIN users_roles ON roles.id = users_roles.role_id").where(users_roles: {user_id: self.id}).first
    if !role.nil?
      role.name
    else
      ""
    end
  end

  # Retorna true si el usuario es un empleado de tipo Doctor, caso contrario false
  def es_doctor?
    self.empleado_type=='Doctor'
  end

  # Law of Demeter
  delegate :persona_nombre, :persona_apellido, :persona_full_name,:persona_email,
           :persona_telefono,:persona_direccion,:cargo,:type,:area_nombre,:id,
           to: :empleado, prefix: true, allow_nil: true
end
