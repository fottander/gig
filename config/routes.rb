Rails.application.routes.draw do

  get 'panels/index'

  devise_for :companies, controllers: {
    registrations: 'companies/registrations'
  }
  devise_scope :copmany do
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

  resources :dashboards, only: [:index]

  resources :jobs, only: [:index, :new, :create, :show]

  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]

end
