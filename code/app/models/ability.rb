class Ability
  include CanCan::Ability



  def initialize(user)
  	if user

  		if user.roles.first.name == "Administrador" || user.id == Configuracion.first.usuario_admin
  			can :manage, :all
  		else
	      @rol = user.roles.first

	      @rol.permissions.each do |permission|

	          can :manage, permission.model.singularize.classify.constantize
	          if permission[:grupo_id] == 5
	          		can :manage, Paciente
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
		        	can :manage, Paciente
		        end
	      end

		    if @rol[:nombre] == ("Historial Médico")
		    	can :manage, Paciente
		    	can :manage, Area
		    	can :manage, Consulta
		    	can :manage, ConsultaOdontologica
		    	can :manage, ConsultaNutricionalPediatrica
		    	can :manage, ConsultaNutricionalAdulto
		    	can :manage, FichaClinico
		    	can :manage, FichaFisioterapeuticaAdulto
		    	can :manage, FichaFisioterapiaNino
		    	can :manage, FichaFonoaudiologica
		    	can :manage, FichaNeurologica
		    	can :manage, FichaNutricionalAdulto
		    	can :manage, FichaNutricionalPediatrica
		    	can :manage, FichaOdontologica
		    	can :manage, FichaPediatrica
		    	can :manage, FichaPsicopedagogica
		    end
		end

  	end
  end

end