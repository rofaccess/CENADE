class HistorialesNutricionalesController < ApplicationController
  before_action :set_submenu, only: [:show, :index ]
  before_action :set_sidebar, only: [:show, :index]
  before_action :set_historial, only: [:show, :print]

  def set_submenu
    @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_historiales'
  end

  def index
    get_pacientes
  end

  def show
  end

  # Obtiene los pacientes con fichas de Nutrición Pediátrica y/o Adulto
  def get_pacientes
    @search = Paciente.ransack(params[:q])
    @pacientes = @search.result
                        .includes(:persona) # para que order por nombre de persona funcione
                        .joins('LEFT OUTER JOIN fichas_nutricionales_adultos ON pacientes.id = fichas_nutricionales_adultos.paciente_id LEFT OUTER JOIN fichas_nutricionales_pediatricas ON pacientes.id = fichas_nutricionales_pediatricas.paciente_id')
                        .where('pacientes.id = fichas_nutricionales_adultos.paciente_id OR pacientes.id = fichas_nutricionales_pediatricas.paciente_id')
                        .order('personas.nombre')
                        .page(params[:page]) # Usa paginates_per del modelo paciente
  end

  # Para el historial se requiere, los datos del paciente, sus fichas y consultas
  # en el área de Nutrición.
  # Si un paciente tiene consultas hechas pero no tiene ninguna ficha, no se mostrará su historial
  def set_historial
    @paciente  = Paciente.find(params[:id])
    @ficha_ped = @paciente.ficha_nutricional_pediatrica
    @ficha_ad  = @paciente.ficha_nutricional_adulto
    @consultas_ped = ConsultaNutricionalPediatrica.where(ficha_nutri_ped_id: @ficha_ped.blank? ? nil : @ficha_ped.id).order(fecha: :desc)
    @consultas_ad  = ConsultaNutricionalAdulto.where(ficha_nutricional_adulto_id: @ficha_ad.blank? ? nil : @ficha_ad.id).order(fecha: :desc)
    area           = Area.find_by_nombre('Nutrición')
    @controles     = Control.where(area_id: area.id,paciente_id: @paciente.id).order(fecha: :desc)
  end

  def print
    respond_to do |format|
        format.pdf do
          render pdf:  'Historial de Paciente (Nutrición)',
          template:    'historiales_nutricionales/print.pdf.erb',
          layout:      'pdf.html',
          title:       'Historial de Paciente (Nutrición)',
          page_height: '13in', #33cm   Oficio
          page_width:  '8.5in',#21.6cm Oficio
          footer: {
            center: '[page] de [topage]',
            right: "#{Formatter.format_datetime(Time.now)}",
            left: "CI Nº: #{@paciente.persona_ci}"
          }
        end
      end
    end
end
