class Ability
  include CanCan::Ability



  def initialize(user)
  	if user
  		if user.roles.first.name == "Administrador"
  			can :manage, :all
  		else
	      @rol = User.find(user).roles.first

	      @rol.permissions.each do |permission|

	          can :manage, permission.model.singularize.classify.constantize
	      end

		    if @rol[:nombre] == ("Clínico")
		    	can :manage, Consulta
		    end
		    if @rol[:nombre] == ("Fisioterapia Adulto")
		    	can :manage, Consulta
		    end
		    if @rol[:nombre] == ("Fisioterapia Pediátrica")
		    	can :manage, Consulta
		    end
		    if @rol[:nombre] == ("Fonoaudiología")
		    	can :manage, Consulta
		    end
		    if @rol[:nombre] == ("Neurología")
		    	can :manage, Consulta
		    end
		    if @rol[:nombre] == ("Nutrición Adulto")
		    	can :manage, ConsultaNutricionalAdulto
		    end
		    if @rol[:nombre] == ("Nutrición Pediátrica")
		    	can :manage, ConsultaNutricionalPediatrica
		    end
		    if @rol[:nombre] == ("Odontología")
		    	can :manage, ConsultaOdontologica
		    end
		    if @rol[:nombre] == ("Pediatría")
		    	can :manage, Consulta
		    end
		    if @rol[:nombre] == ("Psicopedagogía")
		    	can :manage, Consulta
		    end

		    if @rol[:nombre] == ("Historial Médico")
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