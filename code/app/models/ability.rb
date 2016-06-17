class Ability
  include CanCan::Ability



  def initialize(user)
  	if user

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
		        can :manage, permission.model.singularize.classify.constantize
	      end

		    if @rol[:nombre] == ("Historial Médico")
		    	can :manage, Area
		    	can [:set_historial, :get_pacientes], Paciente
		    	can [:get_pacientes], Consulta
		    	can [:get_pacientes], ConsultaOdontologica
		    	can [:get_pacientes], ConsultaNutricionalPediatrica
		    	can [:get_pacientes], ConsultaNutricionalAdulto
		    	can [:get_pacientes], FichaClinico
		    	#can :manage, FichaFisioterapeuticaAdulto
		    	#can :manage, FichaFisioterapiaNino
		    	#can :manage, HistorialesClinicos
		    	#can :index, :paciente
		    	#can :manage, FichaNutricionalAdulto
		    	#can :manage, FichaNutricionalPediatrica
		    	#can :manage, FichaOdontologica
		    	#can :manage, FichaPediatrica
		    	#can :manage, FichaPsicopedagogica
		    end
		    if @rol[:nombre] == ("Atención Profesional")
		    	can [:index, :show, :create_consulta, :create_consulta_ped,
		    		:create_consulta_ad, :create_consulta_odontologica, :create_control,
		    		:set_estado_turno_to_atendido, :get_turnos], Turno
		        can :show, AtencionProfesional
		    	can :create_consulta, Consulta
		    	can :create_consulta_odontologica, ConsultaOdontologica
		    	can :create_consulta_ped, ConsultaNutricionalPediatrica
		    	can :create_consulta_ad, ConsultaNutricionalAdulto

		    end
		end

  	end
  end

end