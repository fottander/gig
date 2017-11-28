Rails.application.routes.draw do

  devise_for :companies, controllers: {
    registrations: 'companies/registrations'
  }
  devise_scope :company do
    authenticated :company do
      root to: 'panels#index'
    end
  end

  devise_for :users, controllers: {
    registrations: 'user/registrations'
  }
  devise_scope :user do
    authenticated :user do
      root to: 'dashboards#index'
    end
  end

  root controller: :index, action: :index

  resources :invites, only: [:new, :create, :index]

  resources :panels, only: [:index]

  resources :payments, only: [:index]

  resources :dashboards, only: [:index]

  resources :jobs, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :applications, except: [:index] do
      member do
        patch :update
        patch :complete
      end
      resources :comments, only: [:create]
    end
  end

  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]

  resources :invoices, only: [:create, :show, :edit, :update, :destroy] do
    member do
      patch :update
      patch :activate
    end
  end

  namespace :api do
    namespace :v1 do
      resources :jobs, only: [:index, :show], defaults: { format: 'json'} do
        resources :applications, only: [:show, :index]
      end
      resources :profiles, only: [:index, :show], defaults: { format: 'json'}
      resources :users, only: [:index, :show], defaults: { format: 'json'}
      resources :companies, only: [:index, :show], defaults: { format: 'json'}
      resources :categories, only: [:index], defaults: { format: 'json'}
      resources :invoices, only: [:index, :show], defaults: { format: 'json'}
    end
  end

end
