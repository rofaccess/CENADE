class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :timeoutable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :secure_validatable

  belongs_to :empleado    
     
end