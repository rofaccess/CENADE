Rails.application.routes.draw do

  get 'atenciones_profesionales/get_turnos' => 'atenciones_profesionales#get_turnos'
  resources :atenciones_profesionales, only: [:index, :show]

  get 'historiales_odontologicos/print' => 'historiales_odontologicos#print'
  resources :historiales_odontologicos, only: [:index, :show]

  get 'historiales_nutricionales/print' => 'historiales_nutricionales#print'
  resources :historiales_nutricionales, only: [:index, :show]

  get 'historiales_clinicos/print' => 'historiales_clinicos#print'
  resources :historiales_clinicos, only: [:index, :show]

  get 'historiales_neurologicos/print' => 'historiales_neurologicos#print'
  resources :historiales_neurologicos, only: [:index, :show]

  get 'historiales_pediatricos/print' => 'historiales_pediatricos#print'
  resources :historiales_pediatricos, only: [:index, :show]

  get 'historiales_fonoaudiologicos/print' => 'historiales_fonoaudiologicos#print'
  resources :historiales_fonoaudiologicos, only: [:index, :show]

  get 'historiales_psicopedagogicos/print' => 'historiales_psicopedagogicos#print'
  resources :historiales_psicopedagogicos, only: [:index, :show]

  get 'consultas_nutricionales_adultos/print_consulta'=>'consultas_nutricionales_adultos#print_consulta'
  get 'consultas_nutricionales_adultos/from_ficha' => 'consultas_nutricionales_adultos#from_ficha'
  resources :consultas_nutricionales_adultos, :except => [:destroy] do
    collection do
      match 'buscar' => 'consultas_nutricionales_adultos#buscar', via: [:get, :post], as: :search
      get 'get_paciente' => 'consultas_nutricionales_adultos#get_paciente'
    end
  end

  get 'historiales_fisioterapeuticos/print' => 'historiales_fisioterapeuticos#print'
  resources :historiales_fisioterapeuticos, only: [:index, :show]

  resources :controles, :except => [:destroy] do
    collection do
      match 'buscar' => 'controles#buscar', via: [:get, :post], as: :search
    end
  end

  get 'fichas_clinicos/check_paciente_has_ficha' => 'fichas_clinicos#check_paciente_has_ficha'
  get 'fichas_clinicos/print_ficha' => 'fichas_clinicos#print_ficha'
  resources :fichas_clinicos do
    collection do
      match 'buscar' => 'fichas_clinicos#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'fichas_clinicos#get_paciente'
    end
  end

  get 'fichas_neurologicas/check_paciente_has_ficha' => 'fichas_neurologicas#check_paciente_has_ficha'
  get 'fichas_neurologicas/print_ficha' => 'fichas_neurologicas#print_ficha'
  resources :fichas_neurologicas do
    collection do
      match 'buscar' => 'fichas_neurologicas#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'fichas_neurologicas#get_paciente'
    end
  end

  get 'consultas_odontologicas/check_paciente_has_ficha' => 'consultas_odontologicas#check_paciente_has_ficha'
  get 'consultas_odontologicas/print_consulta'=>'consultas_odontologicas#print_consulta'
  get 'consultas_odontologicas/from_ficha' => 'consultas_odontologicas#from_ficha'
  resources :consultas_odontologicas, :except => [:destroy] do
    collection do
      match 'buscar' =>'consultas_odontologicas#buscar', via: [:get, :post], as: :search
      get 'get_paciente'=>'consultas_odontologicas#get_paciente'
    end
  end

  get 'consultas_nutricionales_pediatricas/check_paciente_has_ficha' => 'consultas_nutricionales_pediatricas#check_paciente_has_ficha'
  get 'consultas_nutricionales_pediatricas/print_consulta'=>'consultas_nutricionales_pediatricas#print_consulta'
  get 'consultas_nutricionales_pediatricas/from_ficha' => 'consultas_nutricionales_pediatricas#from_ficha'
  resources :consultas_nutricionales_pediatricas, :except => [:destroy] do
    collection do
      match 'buscar' => 'consultas_nutricionales_pediatricas#buscar', via: [:get, :post], as: :search
      get 'get_paciente' => 'consultas_nutricionales_pediatricas#get_paciente'
    end
  end

  get 'fichas_pediatricas/check_paciente_has_ficha' => 'fichas_pediatricas#check_paciente_has_ficha'
  get 'fichas_pediatricas/print_ficha' => 'fichas_pediatricas#print_ficha'
  resources :fichas_pediatricas do
    collection do
      match 'buscar' => 'fichas_pediatricas#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'fichas_pediatricas#get_paciente'
    end
  end

  get 'fichas_nutricionales_adultos/check_paciente_has_ficha' => 'fichas_nutricionales_adultos#check_paciente_has_ficha'
  get 'fichas_nutricionales_adultos/print_ficha'=>'fichas_nutricionales_adultos#print_ficha'
  resources :fichas_nutricionales_adultos, except: [:destroy] do
    collection do
      match 'buscar' => 'fichas_nutricionales_adultos#buscar', via: [:get, :post], as: :search
      get 'get_paciente' => 'fichas_nutricionales_adultos#get_paciente'
    end
  end

  get 'fichas_nutricionales_pediatricas/check_paciente_has_ficha' => 'fichas_nutricionales_pediatricas#check_paciente_has_ficha'
  get 'fichas_nutricionales_pediatricas/print_ficha'=>'fichas_nutricionales_pediatricas#print_ficha'
  resources :fichas_nutricionales_pediatricas, :except => [:destroy] do
    collection do
      match 'buscar' => 'fichas_nutricionales_pediatricas#buscar', via: [:get, :post], as: :search
      get 'get_paciente' => 'fichas_nutricionales_pediatricas#get_paciente'
    end
  end

  get 'fichas_odontologicas/check_paciente_has_ficha' => 'fichas_odontologicas#check_paciente_has_ficha'
  get 'fichas_odontologicas/print_ficha' => 'fichas_odontologicas#print_ficha'
  resources :fichas_odontologicas do
    collection do
      match 'buscar'=>'fichas_odontologicas#buscar', via: [:get, :post],as: :search
      get 'get_paciente'=>'fichas_odontologicas#get_paciente'
    end
  end

  get 'fichas_psicopedagogicas_check_paciente_has_ficha'=> 'fichas_psicopedagogicas#check_paciente_has_ficha'
  get 'fichas_psicopedagogicas/print_ficha'=>'fichas_psicopedagogicas#print_ficha'
  resources :fichas_psicopedagogicas do
    collection do
      match 'buscar'=>'fichas_psicopedagogicas#buscar', via: [:get, :post],as: :search
      get 'get_paciente'=>'fichas_psicopedagogicas#get_paciente'
    end
  end

  get 'fichas_fonoaudiologicas/check_paciente_has_ficha' => 'fichas_fonoaudiologicas#check_paciente_has_ficha'
  get 'fichas_fonoaudiologicas/print_ficha' => 'fichas_fonoaudiologicas#print_ficha'
  resources :fichas_fonoaudiologicas do
    collection do
      match 'buscar' => 'fichas_fonoaudiologicas#buscar', via: [:get, :post], as: :search
      get 'get_paciente' => 'fichas_fonoaudiologicas#get_paciente'
    end
  end

  get 'fichas_fisioterapeuticas_adultos/test' => 'fichas_fisioterapeuticas_adultos#test'
  get 'fichas_fisioterapeuticas_adultos/check_paciente_has_ficha' => 'fichas_fisioterapeuticas_adultos#check_paciente_has_ficha'
  get 'fichas_fisioterapeuticas_adultos/print_ficha' => 'fichas_fisioterapeuticas_adultos#print_ficha'
  resources :fichas_fisioterapeuticas_adultos do
    collection do
      match 'buscar' => 'fichas_fisioterapeuticas_adultos#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'fichas_fisioterapeuticas_adultos#get_paciente'
    end
  end

  get 'ficha_fisioterapia_ninos/check_paciente_id' => 'ficha_fisioterapia_ninos#check_paciente_id'
  get 'ficha_fisioterapia_ninos/print_ficha' => 'ficha_fisioterapia_ninos#print_ficha'
  resources :ficha_fisioterapia_ninos, except: [:destroy] do
    collection do
      match 'buscar' => 'ficha_fisioterapia_ninos#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'ficha_fisioterapia_ninos#get_paciente'
    end
  end
  get 'consultas/consulta_from_ficha' => 'consultas#consulta_from_ficha'

  get 'consultas/print_consulta' => 'consultas#print_consulta'
  resources :consultas, :except => [:destroy] do
    collection do
      match 'buscar' => 'consultas#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'consultas#get_paciente'
    end
  end


  get 'pacientes/new_modal' => 'pacientes#new_modal'
  post 'pacientes/recarga_paciente2' => 'pacientes#recarga_paciente2'

  get 'pacientes/get_paciente' => 'pacientes#get_paciente'
  get 'pacientes/buscar' => 'pacientes#buscar'
  get 'pacientes/print_pacientes' => 'pacientes#print_pacientes'
  get 'pacientes/print_paciente' => 'pacientes#print_paciente'
  get 'pacientes/check_ci' => 'pacientes#check_ci'
  post 'pacientes/recarga_paciente' => 'pacientes#recarga_paciente'
  get 'pacientes/new_paciente_modal' => 'pacientes#new_paciente_modal'
  resources :pacientes

  get 'roles/check_name' => 'roles#check_name'
  resources :roles

  get 'doctores/buscar' => 'doctores#buscar'
  resources :doctores , only: [:update]
  resources :funcionarios , only: [:update]

  get 'turnos/check_paciente' => 'empleados#check_paciente'
  get'turnos/get_paciente' => 'turnos#get_paciente'
  get'turnos/update_profesional' => 'turnos#update_profesional'
  get 'turnos/print_turnos' => 'turnos#print_turnos'
  get '/turnos:id', to: 'turnos#cambiar_estado', as: 'estado'
  resources :turnos do
    collection do
      match 'buscar' => 'turnos#buscar', via: [:get, :post], as: :search
    end
  end

  get 'empleados/print_empleados' => 'empleados#print_empleados'
  get 'empleados/print_empleado' => 'empleados#print_empleado'
  get 'empleados/check_ci' => 'empleados#check_ci'
  resources :empleados
  resources :configuraciones, except: [:show, :destroy, :index]

  get 'usuarios/check_username' => 'usuarios#check_username'
  resources :usuarios do
    collection do
      post 'get_empleado'
    end
  end

  get "perfil_usuarios/edit"
  put "perfil_usuarios/update"
  get "welcome/index_configuracion"
  get "welcome/index_historial"
  get "welcome/index_consultas"
  get "welcome/index_fichas"
  get "welcome/index_atencion_profesional"
  get "welcome/index_personal"
  get "welcome/index_pacientes"
  get "welcome/index_reportes"
  get "welcome/index_turnos"
  get "welcome/index"

  root 'welcome#index'

  devise_for :admins
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
