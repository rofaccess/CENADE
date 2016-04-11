class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  paginates_per 2
  devise :database_authenticatable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :secure_validatable, :registerable

  belongs_to :empleado
  
	def email_required?
	  	false
	     	
	end  

  ransack_alias :usuario, :usuario_username

end
