class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  before_filter :authenticate_user! #Tal vez se quite mas adelante

  protect_from_forgery with: :exception # Usar esto en edit de Datos de la Empresa <%= hidden_field_tag :authenticity_token, form_authenticity_token -%>
 
   def configuracion_general
      @configuracion_general ||= Configuracion.first
    end
  

end
