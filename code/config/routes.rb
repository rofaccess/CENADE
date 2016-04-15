Rails.application.routes.draw do

  get 'pacientes/check_ci' => 'pacientes#check_ci'
  resources :pacientes
  
  get 'roles/check_name' => 'roles#check_name'
  resources :roles
  resources :doctores
  resources :funcionarios
  resources :turnos 

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
