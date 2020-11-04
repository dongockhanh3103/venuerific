Rails.application.routes.draw do
  root 'posts#index'

  get 'about', to: 'pages#about'

  resources :posts do
    collection do
      get :search,  to: 'posts#search'
    end
  end

  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
