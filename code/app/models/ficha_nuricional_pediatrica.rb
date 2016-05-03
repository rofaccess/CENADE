class FichaNuricionalPediatrica < ActiveRecord::Base
	paginates_per 20
	
	#asociaciones
	belongs_to :paciente
	belongs_to :area
	belongs_to :doctor, :foreign_key => :profesional_salud_id

	#cargas automáticas
	before_create :cargar_area_id
	before_create :actualizar_nro



	def actualizar_nro
      ficha = FichaNuricionalPediatrica.last
      if ficha.nil? 
        self.nro_ficha = 1
      elsif  ficha.nro_ficha.nil?
      	self.nro_ficha = 1
      else
        ficha_nro = ficha.nro_ficha
        self.nro_ficha = ficha_nro+1
      end
    end

	def cargar_area_id
		area= Area.where(nombre: 'Nutrición').first.id
		self.area_id= area
	end
	ransack_alias :paciente, :paciente_persona_nombre_or_paciente_persona_apellido_or_paciente_persona_ci
end
