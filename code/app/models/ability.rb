class Ability
  include CanCan::Ability



  def initialize(user)
  	if user
  		can [:edit, :update, :check_username], User

  		alias_action :index, :show, :to => :read
  		if user.roles.first.name == "Administrador" || user.id == Configuracion.first.usuario_admin
  			can :manage, :all
  		else
	      @rol = user.roles.first

	      @rol.permissions.each do |permission|


	          if permission[:grupo_id] == 5
	          		can [:get_paciente, :buscar, :recarga_paciente, :new_modal, :check_ci], Paciente

		          	if permission[:nombre] == ("Clínico")
			    		can :manage, Consulta
				    end
				    if permission[:nombre] == ("Fisioterapia Adulto")
				    	can :manage, Consulta
				    end
				    if permission[:nombre] == ("Fisioterapia Pediátrica")
				    	can :manage, Consulta
				    end
				    if permission[:nombre] == ("Fonoaudiología")
				    	can :manage, Consulta
				    end
				    if permission[:nombre] == ("Neurología")
				    	can :manage, Consulta
				    end
				    if permission[:nombre] == ("Nutrición Adulto")
				    	can :manage, ConsultaNutricionalAdulto
				    end
				    if permission[:nombre] == ("Nutrición Pediátrica")
				    	can :manage, ConsultaNutricionalPediatrica
				    end
				    if permission[:nombre] == ("Odontología")
				    	can :manage, ConsultaOdontologica
				    end
				    if permission[:nombre] == ("Pediatría")
				    	can :manage, Consulta
				    end
				    if permission[:nombre] == ("Psicopedagogía")
				    	can :manage, Consulta
				    end

		        end
		        if permission[:grupo_id] == 3
		        	can [:get_paciente, :buscar, :recarga_paciente, :new_modal, :check_ci], Paciente
		        end
		         if permission[:grupo_id] == 8
			    	can :manage, Area
			    	can [:set_historial, :get_pacientes, :read, :print], Paciente

		    	end
		    	 if permission[:grupo_id] == 6
		    	 	can [:get_paciente, :buscar, :recarga_paciente, :new_modal, :check_ci], Paciente
		    	 	can :manage, Role
			    	can [:read, :create_consulta, :create_consulta_ped,
			    		:create_consulta_ad, :create_consulta_odontologica, :create_control,
			    		:set_estado_turno_to_atendido, :get_turnos], Turno
			        can :show, AtencionProfesional
			    	can :create_consulta, Consulta
			    	can :create_consulta_odontologica, ConsultaOdontologica
			    	can :create_consulta_ped, ConsultaNutricionalPediatrica
			    	can :create_consulta_ad, ConsultaNutricionalAdulto

		    end
		        can :manage, permission.model.singularize.classify.constantize
	      end


		end

  	end
  end

end