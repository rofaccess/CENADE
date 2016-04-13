class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :profile_foto, ProfileFotoUploader
  paginates_per 1

  devise :database_authenticatable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :secure_validatable, :registerable

  belongs_to :empleado
  
	def email_required?
	  	false
	     	
	end  

end
