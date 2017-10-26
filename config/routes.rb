Rails.application.routes.draw do

  get 'comments/new'

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

  resources :panels, only: [:index]

  resources :dashboards, only: [:index]

  resources :jobs, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :applications, except: [:index] do
      resources :comments, only: [:create]
    end
  end

  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]

end
