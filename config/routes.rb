Rails.application.routes.draw do
  resources :posts do
    collection do
      get :search,  to: 'posts#search'
    end
  end

  get 'about', to: 'pages#about'
  devise_for :users

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
