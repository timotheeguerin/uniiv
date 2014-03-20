Uniiv::Application.routes.draw do

  get 'scenario/new'
  get 'course_taking/new'
  get 'course_taking/new_graph_embed'
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

  get 'graph/index'
  get 'test/index'


  root to: 'welcome#index'

  #Admin utils
  namespace :admin do
    get 'utils' => 'utils#index', :as => :utils_home
    namespace :utils do
      get 'course/requirements' => 'course_requirements#index', :as => :check_course_requirements_completed
      get 'course/requirements/:id/none' => 'course_requirements#mark_as_none', :as => :course_requirement_mark_none
      get 'course/requirements/:id/input' => 'course_requirements#input_requirement', :as => :course_requirement_input
      get 'course/requirements/:id/subject_input_requirement' => 'course_requirements#subject_input_requirement', :as => :course_requirement_subject_input
      post 'course/requirements/:id/input' => 'course_requirements#save_requirement', :as => :course_requirement_input_save
      get 'course/loader/load' => 'course_loader#new', :as => :course_load_new
      post 'course/loader/load' => 'course_loader#load', :as => :course_load_create
      post 'course/loader/load_all' => 'course_loader#load_all', :as => :course_load_all
      get 'program/editor' => 'program_editor#index', :as => :program_editor
    end
  end

  devise_for :users, :controllers => {:registrations => 'registrations'}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'


  #User university controller
  get 'user/university/show' => 'user_university#show', :as => :user_university_show
  get 'user/university/edit' => 'user_university#edit', :as => :user_university_edit
  post 'user/university/edit' => 'user_university#update', :as => :user_university_update
  post 'user/university/delete' => 'user_university#delte', :as => :user_university_delete

  #User faculty controller
  get 'user/faculty/show' => 'user_faculty#show', :as => :user_faculty_show
  get 'user/faculty/edit' => 'user_faculty#edit', :as => :user_faculty_edit
  post 'user/faculty/edit' => 'user_faculty#update', :as => :user_faculty_update
  post 'user/faculty/delete' => 'user_faculty#delte', :as => :user_faculty_delete


  #User faculty controller
  get 'user/program/show' => 'user_programs#show', :as => :user_programs_show
  get 'user/program/new' => 'user_programs#new', :as => :user_programs_new
  post 'user/program/new' => 'user_programs#create', :as => :user_programs_create
  post 'user/program/delete' => 'user_programs#delete', :as => :user_programs_delete

  get 'test' => 'test#index'

  #University controller
  get 'university/search/autocomplete' => 'university#search_autocomplete', :as => :university_search_autocomplete

  #Faculty controller
  get 'faculty/search/autocomplete' => 'faculty#search_autocomplete', :as => :faculty_search_autocomplete

  #Program controller
  get 'program/search/autocomplete' => 'program#search_autocomplete', :as => :program_search_autocomplete
  get 'program/new' => 'program#new', :as => :program_new
  post 'program/new' => 'program#create', :as => :program_create
  get 'program/:id', to: 'program#show', as: 'program'
  get 'program/:id/graph/embed' => 'program#graph_embed'

  get 'program/:id/edit' => 'program#edit', :as => :program_edit
  patch 'program:id/edit' => 'program#update', :as => :program_update
  post 'program/delete' => 'program#delete', :as => :program_delete

  #Group restricion
  get 'program/group/restriction/create'=> 'program/group_restriction#list', :as => :program_group_restriction_list
  post 'program/group/restriction/create' => 'program/group_restriction#create', :as => :program_group_restriction_create
  post 'program/group/restriction/delete' => 'program/group_restriction#delete', :as => :program_group_restriction_delete


  #Group controller
  get 'program/group/new' => 'program_group#new', :as => :program_group_new
  get 'program/group/:id' => 'program_group#show', as: 'group'
  get 'program/group/:id/graph/embed' => 'program_group#graph_embed'
  post 'program/group/new' => 'program_group#create', :as => :program_group_create
  get 'program/group/:id/edit' => 'program_group#edit', :as => :program_group_edit
  patch 'program/group/:id/edit' => 'program_group#update', :as => :program_group_update
  post 'program/group/delete', to: 'program_group#delete', :as => :program_group_delete

  #Group subject course list controller
  get 'program/group/subject_course_list/new' => 'group_subject_course_list#new', :as => :group_subject_course_list_new
  post 'program/group/subject_course_list/new' => 'group_subject_course_list#create', :as => :group_subject_course_list_create
  get 'program/group/subject_course_list/:id/edit' => 'group_subject_course_list#edit', :as => :group_subject_course_list_edit
  post 'program/group/subject_course_list/:id/edit' => 'group_subject_course_list#update', :as => :group_subject_course_list_update
  post 'program/group/subject_course_list/delete' => 'group_subject_course_list#delete', :as => :group_subject_course_list_delete

  #Graph controller
  get 'mygraph' => 'graph#show', :as => :user_graph
  get 'mygraph/data' => 'graph#user_data', :as => :user_graph_data
  get 'graph/program/:id/data' => 'graph#program_graph_data', :as => 'program_graph_data'
  get 'graph/program/:id' => 'graph#show_program_graph', :as => 'program_graph'

  #Course controller
  get 'course/search/data' => 'course#search_json', :as => :search_course_json
  get 'course/search/autocomplete' => 'course#search_autocomplete', :as => :search_course_autocomplete
  get 'course/search/show' => 'course#search_list', :as => :search_course_list
  get 'course/:id', to: 'course#show', as: :course
  get 'course/:id/show' => 'course#show'
  get 'course/:id/graph/embed' => 'course#graph_embed', :as => :course_graph_embed
  get 'course/:id/json' => 'course#json'

  #Course review controller
  get 'course/:course_id/review/' => 'course_review#index', :as => :course_reviews
  get 'course/:course_id/review/:id/show' => 'course_review#show', :as => :course_review
  get 'course/:course_id/review/new' => 'course_review#new', :as => 'course_review_new'
  post 'course/:course_id/review/new' => 'course_review#create', :as => 'course_review_create'
  get 'course/:course_id/review/new/graph/embed' => 'course_review#new_graph_embed', :as => :course_review_new_graph_embed, :defaults => {:graph_embed => true}
  post 'course/:course_id/review/new/graph/embed' => 'course_review#create', :as => :course_review_create_graph_embed, :defaults => {:graph_embed => true}

  #User
  get 'education' => 'user_dashboard#index', :as => :user_education
  get 'education/status' => 'user_dashboard#education_status', :as => :user_education_status_content
  get 'education/course_taking_content' => 'user_dashboard#user_course_taking_content', :as => :user_education_course_taking_content
  get 'education/course_completed_content' => 'user_dashboard#user_course_completed_content', :as => :user_education_course_completed_content

  #User course controller
  scope :module => 'user' do
    get 'user/course/add' => 'course_taking#add_course', :as => :user_add_course
    post 'user/course/add' => 'course_taking#handle_add_course', :as => :handle_user_add_course
    get 'user/course/sort' => 'course_taking#sort_course', :as => :user_sort_course
    get 'course/:id/take' => 'course_taking#new', :as => :user_take_course
    post 'course/:id/take' => 'course_taking#create', :as => 'user_take_course_create'
    get 'course/:id/take/graph/embed' => 'course_taking#new_graph_embed', :as => 'user_take_course_graph_embed'
    post 'course/:id/take/graph/embed' => 'course_taking#create', :as => 'user_take_course_create_graph_embed', :defaults => {:graph_embed => true}
    post 'course/untake' => 'course_taking#remove', :as => :user_remove_course_form
    post 'course/:id/untake' => 'course_taking#remove', :as => :user_remove_course
    post 'course/:id/untake/graph/embed' => 'course_taking#remove', :as => 'user_remove_course_ge', :defaults => {:graph_embed => true}
    get 'course/:id/complete' => 'course_taking#complete', :as => 'user_complete_course'
    get 'course/:id/complete/graph/embed' => 'course_taking#complete', :as => 'user_complete_course_ge', :defaults => {:graph_embed => true}
    post 'course/:id/complete' => 'course_taking#create_complete', :as => :user_mark_complete_course
    post 'course/:id/complete/graph/embed' => 'course_taking#create_complete', :as => 'user_mark_complete_course_ge', :defaults => {:graph_embed => true}
    post 'user/course/take/update' => 'course_taking#update_course_taking', :as => :update_course_taking

    #User advanced standing controller
    get 'user/advanced-standings' => 'advanced_standing#index', :as => :user_advanced_standings
    post 'user/advanced-standings/create' => 'advanced_standing#create', :as => :user_advanced_standings_create
    post 'user/advanced-standings/remove' => 'advanced_standing#remove', :as => :user_advanced_standings_remove
    post 'user/advanced-standings/setcredit' => 'advanced_standing#set_credit', :as => :user_advanced_standings_setcredit

    #Scenario controller
    get 'scenario/new' => 'scenario#new', :as => :user_new_scenario
    post 'scenario/remove' => 'scenario#remove', :as => :user_remove_scenario
    post 'scenario/setmain' => 'scenario#set_main', :as => :user_setmain_scenario
  end

  scope :module => 'utils' do
    get 'utils/finalgradecalculator' => 'final_grade_calculator#index', :as => :utils_fgc
    get 'utils/finalgradecalculator/search' => 'final_grade_calculator#search', :as => :utils_fgc_search
    get 'utils/finalgradecalculator/course/:id' => 'final_grade_calculator#show', :as => :utils_fgc_course
    post 'utils/finalgradecalculator/course/:id/create_grade' => 'final_grade_calculator#create_grade', :as => :utils_fgc_create_grade
    post 'utils/finalgradecalculator/course/:id/edit_grade_name' => 'final_grade_calculator#edit_grade_name', :as => :utils_fgc_edit_grade_name
    post 'utils/finalgradecalculator/course/:id/edit_grade_value' => 'final_grade_calculator#edit_grade_value', :as => :utils_fgc_edit_grade_value
    post 'utils/finalgradecalculator/course/:id/remove_grade' => 'final_grade_calculator#remove_grade', :as => :utils_fgc_remove_grade

    post 'utils/finalgradecalculator/course/:id/create_group' => 'final_grade_calculator#create_group', :as => :utils_fgc_create_group
    post 'utils/finalgradecalculator/course/:id/edit_percent' => 'final_grade_calculator#edit_group_percent', :as => :utils_fgc_edit_group_percent
    post 'utils/finalgradecalculator/course/:id/add_grade_to_group' => 'final_grade_calculator#add_grade_to_group', :as => :utils_fgc_add_grade_to_group
    post 'utils/finalgradecalculator/course/:id/remove_group' => 'final_grade_calculator#remove_group', :as => :utils_fgc_remove_group

    post 'utils/finalgradecalculator/course/:id/create_scheme' => 'final_grade_calculator#create_scheme', :as => :utils_fgc_create_scheme
    post 'utils/finalgradecalculator/course/:id/remove_scheme' => 'final_grade_calculator#remove_scheme', :as => :utils_fgc_remove_scheme

    post 'utils/finalgradecalculator/course/:id/edit_final_percent' => 'final_grade_calculator#edit_final_percent', :as => :utils_fgc_edit_final_percent


    get 'utils/transcript/loader' => 'transcript_loader#index', :as => :transcript_loader
    get 'utils/transcript/loader/parse' => 'transcript_loader#parse_show', :as => :transcript_loader_parse
    post 'utils/transcript/loader/parse' => 'transcript_loader#parse'
    get 'utils/transcript/loader/parse/manual' => 'transcript_loader#parse_manual_show', :as => :transcript_loader_parse_manual
    post 'utils/transcript/loader/parse/manual' => 'transcript_loader#parse_manual'
  end

  #manytomany relationship contrller
  get 'mtmrelationship' => 'manytomany_relationship#show', :as => :manytomany_relationship
  get 'mtmrelationship/list' => 'manytomany_relationship#list', :as => :manytomany_relationship_list
  post 'mtmrelationship/delete' => 'manytomany_relationship#delete', :as => :manytomany_relationship_delete
  post 'mtmrelationship/create' => 'manytomany_relationship#create', :as => :manytomany_relationship_create
  get 'mtmrelationship/search/autocomplete' => 'manytomany_relationship#search_autocomplete', :as => :manytomany_relationship_search_autocomplete


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
