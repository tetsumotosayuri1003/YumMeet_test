Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get 'boards', to: 'boards#index', as: 'boards'

  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_use', to: 'static_pages#terms_of_use'

  resources :users, only: %i[new create show]
  resources :boards, only: %i[index new create show edit update destroy] do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :favorites
    end
  end
  resources :favorites, only: %i[create destroy]
  resource :profile, only: %i[show edit update]

  resources :boards do
    resources :comments, only: [:create, :destroy, :edit, :update]

    member do
      post 'bookmark', to: 'bookmarks#create'
      delete 'unbookmark', to: 'bookmarks#destroy'
    end
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
