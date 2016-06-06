class AtencionProfesional < ActiveRecord::Base

  # Establece la ubicación del parcial show según el área
  def self.set_show_partial_path(area_nombre)
    case area_nombre
    when "Clínico"
      '/clinico/show'
    when "Fisioterapia"
      '/fisioterapia/show'
    when "Fonoaudiología"
      '/fonoaudiologia/show'
    when "Neurología"
      '/neurologia/show'
    when "Nutrición"
      '/nutricion/show'
    when "Odontología"
      '/odontologia/show'
    when "Pediatría"
      '/pediatria/show'
    when "Psicopedagogía"
      '/psicopedagogia/show'
    else
    end
  end

end