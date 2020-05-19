Rails.application.routes.draw do
 devise_for :users
 root 'welcome#index'
 
 get "/", to: 'users#sign_in'

 get "/page", to: "page#index"

get '/activity_logs', to: 'activity_logs#index'
 namespace 'api' do
   resources :activities
   resources :babies
   resources :activity_logs
   resources :assistants
   resources :babies do
      resources :activity_logs
   end
end

resources :activities
resources :babies
resources :assistants

end
