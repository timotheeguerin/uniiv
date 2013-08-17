Uniiv::Application.routes.draw do
  get "static_page/uniiv"
  get "static_page/story"
  get "static_page/team"
  get "static_page/getinvolved"
  get "static_page/suggestions"
  get "static_page/bugreports"
  get "static_page/cookies"
  get "static_page/privacy"
  get "static_page/termsofuse"
  get "user_settings/index"
  get "program_group/index"
  get "program_group/graph_embed"
  get "program/index"
  get "program/graph_embed"
  post "user_programs/removeProgram"
  post "user_emails/removeEmail"
  post "user_emails/makeDefault"
  post "user_emails/addEmail"
  get "user_emails/index"
  get "user_courses/add"

  get "user_courses/index"
  get 'user_dashboard/index'
  get 'user_programs/show'
  get 'user_programs/new'
  post 'user_programs/create'
  get 'user_programs/edit'
  get 'user_programs/update'
  get 'user_programs/delete'
  get 'user_faculty/show'
  get 'user_faculty/new'
  get 'user_faculty/create'
  get 'user_faculty/edit'
  post 'user_faculty/update'
  get 'user_faculty/delete'
  get 'user_university/show'
  get 'user_university/new'
  get 'user_university/create'
  get 'user_university/edit'
  post 'user_university/update'
  get 'user_university/delete'
  get 'graph/index'
  get 'test/index'

  devise_for :users, :controllers => {:registrations => 'registrations'}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root to: 'welcome#index'

  get 'test' => 'test#index'


  #Graph controller
  get 'mygraph' => 'graph#show', as: 'user_graph'
  get 'mygraph/data' => 'graph#user_data', as: 'user_graph_data'
  get 'graph/:id/data' => 'graph#data'
  get 'graph/program/:id/data' => 'graph#program_graph_data', :as => 'program_graph_data'
  get 'graph/program/:id' => 'graph#show_program_graph', :as => 'program_graph'

  #Course controller
  get 'course/:id', to: 'course#show', as: 'course'
  get 'course/:id/show' => 'course#show'
  get 'course/:id/graph/embed' => 'course#graph_embed'
  get 'course/:id/json' => 'course#json'

  #Program controller
  get 'program/:id', to: 'program#show', as: 'program'
  get 'program/:id/graph/embed' => 'program#graph_embed'

  #Group controller
  get 'group/:id', to: 'program_group#show', as: 'group'
  get 'group/:id/graph/embed' => 'program_group#graph_embed'

  #User course controller
  post 'user_courses/add_course'
  post 'user_courses/remove_course_completed'
  post 'user_courses/remove_course_taking'
  post 'user_courses/complete_course_taking'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with 'rake routes'.

  # You can have the root of your site routed with 'root'
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
