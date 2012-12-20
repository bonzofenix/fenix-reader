FenixReader::Application.routes.draw do

  resources :channels 
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :feed_entries do
    resources :comments
  end

  scope module: 'feed_entries', as: :feeds do
    post :subscribe
  end
end
