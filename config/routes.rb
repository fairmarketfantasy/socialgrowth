Socialgrowth::Application.routes.draw do
  resources :authentications
  #resources :campaigns
  #resources :twitter_campaigns, controller: :campaigns, type: "TwitterCampaign"
  resources :campaigns do
    get 'search', on: :collection
    get 'toggle', on: :collection
  end

  devise_for :users

  match '/campaigns/:id/pane' => 'campaigns#pane', via: [:get, :post]
  match '/auth/:provider/callback' => 'authentications#create', via: [:get, :post]
  match '/authentication/add' => 'authentications#unauthenticated', via: [:get, :post]
  match '/application/home' => 'application#home', via: [:get, :post]
  match "/signout" => "application#destroy", :as => :signout, via: [:get, :post]

  root 'authentications#index'

  get '/healthcheck' => 'application#healthcheck' 
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
