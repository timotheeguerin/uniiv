Uniiv::Application.routes.draw do

  get "course_taking/new"
  get "course_taking/new_graph_embed"
  get 'static_page/uniiv'
  get 'static_page/story'
  get 'static_page/team'
  get 'static_page/getinvolved'
  get 'static_page/suggestions'
  get 'static_page/bugreports'
  get 'static_page/cookies'
  get 'static_page/privacy'
  get 'static_page/termsofuse'
  get 'user_settings/index'
  get 'program_group/index'
  get 'program_group/graph_embed'
  get 'program/index'
  get 'program/graph_embed'
  post 'user_programs/removeProgram'
  post 'user_emails/removeEmail'
  post 'user_emails/makeDefault'
  post 'user_emails/addEmail'
  get 'user_emails/index'
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
  get 'course/:id/graph/embed' => 'course#graph_embed', :as => 'course_graph_embed'
  get 'course/:id/json' => 'course#json'

  #Course review controller
  get 'course/:course_id/review/' => 'course_review#index', :as => 'course_reviews'
  get 'course/:course_id/review/:id/show' => 'course_review#show', :as => 'course_review'
  get 'course/:course_id/review/new' => 'course_review#new', :as => 'course_review_new'
  post 'course/:course_id/review/new' => 'course_review#create', :as => 'course_review_create'
  get 'course/:course_id/review/new/graph/embed' => 'course_review#new_graph_embed', :as => 'course_review_new_graph_embed'
  post 'course/:course_id/review/new/graph/embed' => 'course_review#create_graph_embed', :as => 'course_review_create_graph_embed'

  #Program controller
  get 'program/:id', to: 'program#show', as: 'program'
  get 'program/:id/graph/embed' => 'program#graph_embed'

  #Group controller
  get 'group/:id', to: 'program_group#show', as: 'group'
  get 'group/:id/graph/embed' => 'program_group#graph_embed'

  #User course controller
  get 'course/user/add' => 'user/course_taking#add_course', :as => 'user_add_course'
  get 'course/:id/take' => 'user/course_taking#new', :as => 'user_take_course'
  post 'course/:id/take' => 'user/course_taking#create', :as => 'user_take_course_create'
  get 'course/:id/take/graph/embed' => 'user/course_taking#new_graph_embed', :as => 'user_take_course_graph_embed'
  post 'course/:id/take/graph/embed' => 'user/course_taking#create', :as => 'user_take_course_create_graph_embed', :defaults => {:graph_embed => true}
  post 'course/:id/untake' => 'user/course_taking#remove', :as => 'user_take_course_remove'
  post 'course/:id/untake/graph/embed' => 'user/course_taking#remove', :as => 'user_take_course_remove_graph_embed', :defaults => {:graph_embed => true}
  get 'course/:id/complete' => 'user/course_taking#complete', :as => 'user_complete_course'
  get 'course/:id/complete/graph/embed' => 'user/course_taking#complete', :as => 'user_complete_course_ge', :defaults => {:graph_embed => true}
  post 'course/:id/complete' => 'user/course_taking#create_complete', :as => 'user_mark_complete_course'
  post 'course/:id/complete/graph/embed' => 'user/course_taking#create_complete', :as => 'user_mark_complete_course_ge', :defaults => {:graph_embed => true}

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
