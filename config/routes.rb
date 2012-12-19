FenixReader::Application.routes.draw do
  resources :channels

  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :feeds, only: [:index]
  scope module: 'feeds', as: :feeds do
    post :subscribe
  end
end
