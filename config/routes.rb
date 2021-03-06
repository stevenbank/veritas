VeritasWeb::Application.routes.draw do
  resources :tests


  mount Ckeditor::Engine => '/ckeditor'

  match "login" => "sessions#new", :via => [:get]
  match "login" => "sessions#create", :via => [:post]
  match "logout" => "sessions#destroy"
  
  resources :sessions  
  resources :settings
  resources :contact_queue_items, :path => "contact-queue"
  resources :contacts
  resources :podcasts
  resources :default
  
  match "/" => "default#index", :as => "default"

  match "podcast" => "podcasts#feed", :defaults => { :format => 'rss' }, :as => "podcast_feed"
  
  match "attendances/print" => 'attendances#print', :as => "print_attenance"
  match "attendances/:date" => 'attendances#show', :as => "attendances_by_date"
  match "attendances/:date/:contact_id" => 'attendances#update'
  resources :attendances
  
  resources :signups
  match "signups/:id/signup" => "signups#signup", :as => "user_signup"
  
  match "tools" => "tools#index"
  match "tools/:action/:type" => "tools#%{action}"
  match "tools/:action" => "tools#%{action}"
  match "tools/text/:type/send" => "tools#text_send"
  match "tools/email/:type/send" => "tools#email_send"
  
  match "admin" => redirect("/contacts")
  match "mobile" => redirect("/?mobile=1")

  root :to => 'default#index'

  #catch all redirect to root
  match '*path' => redirect('/')   unless Rails.env.development?

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
