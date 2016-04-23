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

end
