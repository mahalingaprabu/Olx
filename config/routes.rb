LeaveSystem::Application.routes.draw do
 
match '/employees/get_emp_manager_name/:id' => 'employees#get_emp_manager_name' 

match '/employees/emp_leave_status' => 'employees#emp_leave_status'

match '/articles/:id/save_comment' => 'articles#save_comment'

match '/employees/employee_separation' => 'employees#employee_separation' 
match '/leave_credits/:id/ohupdate' => 'leave_credits#ohupdate'

resource :authentication, :controller => "authentication" do
  member do
     match :login
     get :logout
     match :set_password
     match :forgot_password
     match :reset_password
  end
end

resources :holidays, :controller => 'holidays' do
  member do
      post 'destroy/id', :action => :destroy
  end
end

resources :employees, :controller => "employees" do
   member do
       put :update
       get :leave_balances
       get :my_leave_approvals
       get :my_leaves
       get :team_leaves   
      # get :employee_seperation
	get :anew, :action => :anew
post :acreate, :action => :acreate
       post 'destroy/id', :action => :destroy
   end


   resources :leaves, :controller => "leaves" do
    member do

	post :update
       get :request_details
       post :action_leave
       get :quarterly_credits
    end

   end
end

resources :articles do
member do

post 'aindex', :action => :aindex
get 'anew/id', :action => :anew
post 'acreate/id', :action => :acreate
end
end 

resources :leaves, :controller => "leave_credits" do

    collection do
get :ohindex
get :ohnew
post :ohcreate
get :ohedit
       get :show
       get :quarterly_credits
       post :rt_qlc
       get :annual_credits
       post :rt_alc
    end
end

#match '/' => 'employees#hub', :as => :home

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
  #root :to => 'employees#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
