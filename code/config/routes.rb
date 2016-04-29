Rails.application.routes.draw do

  get 'check_paciente_id' => 'fichas_fonoaudiologicas#check_paciente_id'
  resources :fichas_fonoaudiologicas do
    collection do
      match 'buscar' => 'fichas_fonoaudiologicas#buscar', via: [:get, :post], as: :search
      get 'get_paciente' => 'fichas_fonoaudiologicas#get_paciente'
    end
  end
  get 'ficha_fisioterapia_ninos/check_paciente_id' => 'ficha_fisioterapia_ninos#check_paciente_id'
  get 'ficha_fisioterapia_ninos/print_ficha' => 'ficha_fisioterapia_ninos#print_ficha'

  resources :ficha_fisioterapia_ninos do
    collection do
      match 'buscar' => 'ficha_fisioterapia_ninos#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'ficha_fisioterapia_ninos#get_paciente'
    end
  end

  get 'consultas/print_consulta' => 'consultas#print_consulta'
  resources :consultas do
    collection do
      match 'buscar' => 'consultas#buscar', via: [:get, :post], as: :search
      get'get_paciente' => 'consultas#get_paciente'
      get'recarga_profesional' => 'consultas#recarga_profesional'
    end
  end

  get 'pacientes/print_pacientes' => 'pacientes#print_pacientes'
  get 'pacientes/print_paciente' => 'pacientes#print_paciente'
  get 'pacientes/check_ci' => 'pacientes#check_ci'
  post 'pacientes/recarga_paciente' => 'pacientes#recarga_paciente'
  get 'pacientes/new_paciente_modal' => 'pacientes#new_paciente_modal'
  resources :pacientes
  get 'roles/check_name' => 'roles#check_name'
  resources :roles
  resources :doctores
  resources :funcionarios

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
  resources :configuraciones

  get 'usuarios/check_username' => 'usuarios#check_username'
  resources :usuarios do
    collection do
      post 'get_empleado'
    end
  end

  get "perfil_usuarios/edit"
  put "perfil_usuarios/update"
  get "welcome/index_configuracion"
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
