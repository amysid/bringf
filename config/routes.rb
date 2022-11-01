Rails.application.routes.draw do
  

  # get 'users/index'

  # get 'users/new'

  # root :to => 'homes#landing'
  root 'welcomes#index'
  get '/about_us' => 'welcomes#about_us'
  #get '/pricing' => 'welcomes#pricing'
  get '/request' => 'travellers#request'
  get '/faq' => 'welcomes#faq'
  get '/privacy' => 'welcomes#privacy'
  get '/condition' => 'welcomes#condition'
  get '/blog' => 'welcomes#blog'
  get '/refund_policy' => 'welcomes#refund_policy'
  get '/disclaimer_policy' => 'welcomes#disclaimer_policy'
  
  post 'create_transaction',to: 'transactions#create_transaction'
  namespace :admin do
    get 'contents/index'
  end
  
  get '/admin' => 'admin/sessions#new'
  # admin
  namespace :admin do
    resources :sessions do
      collection do 
        get :render_to_email_field
        post :forget_password
        post :update_password 
      end
    end
    resources :admin_users do
     member do
          get :change_password
          post :update_password
        end
      end
    resources :conditions
    resources :privacies
    resources :faqs
    resources :blogs
    resources :refund_policys
    resources :disclaimer_policys
    resources :homes do
      collection do
        get :filter_date
      end
    end
    # resources :homes do 
    #   collection do
    #     post :country_change
    #   end
    # end
    resources :locations do
      collection do
        post :country_change
      end
     end 
    resources :contents
    resources :pricing_informations do
      collection do
        post :create_commission
        get :find_weight_from_country
      end
    end
    resources :transactions
    resources :journeyrequests do
      collection do
        get :sort_order
      end
    end
    resources :newsletters do
        collection do 
         get :subscription_status_change
        end 
    end
    resources :countries do
      collection do 
        get 'new_state'
        post 'create_state'
        post 'edit_state'
        post 'update_state'
        delete 'destroy_state'
        #post 'country_change'
      end
    end
    resources :users do
      member do
        get 'unblock'
     end
      collection do
        post :country_change
      end
  end
end
# admin end
get "/dashboard" => "dashboards#index"
 #resources :sessions
resources :users do
      collection do
        post :country_change
        post :state_change
        get :confirm_transaction
        post :bank_details
        get  :notification
        
      end
      member do
        put 'update_password'
      end  
  end
  resources :dashboards do
    collection do
     get :sort_by_filter
     get :accept
     get :receiver_deliver_status
     get :accept_carry_request
    end
  end
  resources :accounts
  resources :pricings do
    collection do
        get :find_weight_from_country
      end
    end
  resources :travellers do
    collection do
      post :country_change
      post :state_change
      get :request_list
     
      get :traveller_list

    end
  end
 
  resources :senders do
  collection do
    post :country_change
    get :sender_request_list
    post :state_change
  end
end
  resources :contacts
  resources :welcomes do
  collection do
    post :newsletter
   
  end
end

  resources :user_sessions do
     collection do
      post :forget_password
    end
  end

resources :transactions
resources :homes do
     collection do
        get 'contact_us'
        get 'landing'
        get 'about_us'
        get 'pricing'
        get 'sender'
        get 'traveller'

  end

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  
   
   get 'book_transaction',to: 'transactions#book_transaction'
   post 'create_transaction',to: 'transactions#create_transaction'
   post 'cancel_transaction',to: 'transactions#cancel_transaction'
   get 'confirm_transaction',to: 'transactions#confirm_transaction'
   post 'create_receiver',to: 'transactions#create_receiver'
   post 'rating',to: 'users#rating'
   post 'cancel_request',to: 'dashboards#cancel_request'


   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # api_version(:module => "api/v1", :header => {:name => "Accept", :value => "application/Bringitfast; version=1"}) do
  api_version(:module => "api/v1", :path => {:value => "v1"}) do
    
    resources :users do
     collection do
          post :sign_up
          post :login
          post :logout
          get  :view_profile
          post :update_profile
          post :forget_password
          post :change_password
          post :location_address
      end
    end

     resources :pricings do
      collection do
        get :pricing_country
        post :find_weight_from_country
        post :pricing_list
      end
    end
   
    resources :senders do
      collection do 
        get :all_country
        post :state
        post :city
        post :sender_form
        post :sent_order_details
        post :edit_luggage
        post :update_luggage
        post :package_image
      end
    end
    
      resources :transactions do
       collection do
        get :all_transaction
        post :create_transaction
        post :create_receiver
       end 
      end  


     resources :dashboards do
      collection do
       get :carried_laggage_list
       get :sent_laggage_list 
       get :received_laggage_list
       get :pending_carry_request_list
       get :pending_receive_request_list
       post :sent_laggage_list_view_details
       post :accept_carry_request
       post :accept_receive_request
      end
    end

    resources :travellers do
      collection do
       post :traveller_list
       post :view_request_list
       post :carried_order_details
       post :traveler_form
      end
    end

  end

  get '/users/:id/confirm_email' => "api/v1/users#confirm_email" ,as: "confirm_email"   
end
