class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :authenticate_user! #Tal vez se quite mas adelante
  before_filter :configuracion_general

  protect_from_forgery with: :exception # Usar esto en edit de Datos de la Empresa <%= hidden_field_tag :authenticity_token, form_authenticity_token -%>

   def configuracion_general
      @configuracion_general = Configuracion.first
    end

   rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'Usted no esta autorizado para acceder a la página solicitada.'
    redirect_to root_path
  end
  protected
    def self.permission
      self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    end



    def self.permission
    return name = controller_name.classify.constantize
  end

   def get_all_views
    if not current_user.blank?
      @role = Permission.get_permissios(current_user)
    end
  end

    def load_permissions
      @current_permissions = current_user.roles.each do |role|
        role.permissions.collect{|i| [i.subject_class, i.action]}
      end
    end


end
