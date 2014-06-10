MapleAndOak::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'static_pages#home'

  resources :contacts, only: [:new, :create]

  resources :profiles do
    member do
      put :unpublish
      put :publish
      put :approve
      put :deny
      put :submit_for_approval
    end
  end

  resources :subscriptions
  resources :users
  resources :conversations, only: [:index] do
    member do
      put :trash
      put :delete
      put :untrash
    end
  end

  resources :messages, only: [:show] do
    member do
      post :reply
      post :create
    end
  end      


  match '/signup',          to:     'plans#signup',             via: 'get'
  match '/home',            to:     'static_pages#home',        via: 'get'
  match '/about',           to:     'static_pages#about',       via: 'get'
  match '/contact',         to:     'contacts#new',             via: 'get'
  match '/admin',           to:     'admin_pages#dashboard',    via: 'get'


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
