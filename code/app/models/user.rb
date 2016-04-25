class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :profile_foto, ProfileFotoUploader
  paginates_per 20

  devise :database_authenticatable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :empleado
  has_many :consultas

  validates :username, length: {maximum: Domain::USERNAME, minimum: 3}
  
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

end
