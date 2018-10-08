Rails.application.routes.draw do



  get 'sport/index'

  devise_for :users
  get 'homepage/index'
  root 'homepage#index'
  #schools
  get 'school/index'
  get 'school', to: 'school#index'
  get 'school/list'
  get 'school/new'
  post 'school/create'
  patch 'school/update'
  get 'school/show'
  get 'school/edit'
  get 'school/delete'
  get 'school/update'
  #Locations
  get 'location/index'
  get 'location', to: 'location#index'
  get 'location/list'
  get 'location/new'
  post 'location/create'
  patch 'location/update'
  get 'location/show'
  get 'location/edit'
  get 'location/delete'
  get 'location/update'
  #Messages
  get 'message/index'
  get 'message', to: 'message#index'
  get 'message/list'
  get 'message/new'
  post 'message/create'
  patch 'message/update'
  get 'message/show'
  get 'message/edit'
  get 'message/delete'
  get 'message/update'
  #Sport
  get 'sport/index'
  get 'sport', to: 'sport#index'
  get 'sport/list'
  patch 'sport/update'
  get 'sport/show'
  get 'sport/new'
  post 'sport/create'
 #All AllSports
   get 'all_sports/index'
   get 'all_sports', to: 'sport#index'
   get 'all_sports/list'
   get 'all_sports/show'
  #Game
  post 'game/create'
  get 'game/delete', to: 'sport#delete'
  get 'sport/edit'
  get 'sport/school'
  #All tournaments
  get 'tournaments/index'
  get 'tournaments', to: 'tournaments#index'
  get 'tournaments/list'
  get 'tournaments/show'
  get 'tournaments/show_tournament'
  get 'tournaments/new'
  post 'tournaments/create'
  get 'tournaments/edit'
  get 'tournaments/edit_tournament'
  get 'tournaments/delete'
  get 'tournaments/update'
  patch 'tournaments/update_tournament_game'
  patch 'tournaments/update_tournament'

  #Rules
    get 'sport_rules/index'
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
