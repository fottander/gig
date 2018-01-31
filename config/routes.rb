Rails.application.routes.draw do

  devise_for :admins
  devise_scope :admin do
    authenticated :admin do
      root to: 'administrations#index'
    end
  end

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

  resources :users, only: [:index]

  resources :users_without_profiles, only: [:index]

  resources :companies, only: [:index]

  resources :panels, only: [:index]

  resources :payments, only: [:index, :show]

  resources :ezpayments, only: [:show]

  resources :adminpayments, only: [:index, :new]

  resources :howitworks, only: [:index]

  resources :dashboards, only: [:index]

  resources :administrations, only: [:index]

  get 'applications' => 'applications#index', as: :applications

  resources :filter_applications, only: [:index]

  resources :jobs, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :applications, except: [:index] do
      member do
        patch :update
      end
      resources :comments, only: [:create]
    end
  end

  resources :categories, only: [:create, :destroy, :edit, :update]

  resources :adminjobs, only: [:index, :show]

  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]

  resources :adminprofiles, only: [:index]

  resources :admininvoices, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch :pay
      patch :pay_salary
      patch :activate
    end
  end

  resources :filter_invoices, only: [:index, :new]

  resources :ezinvoices, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :adminezinvoices, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch :pay
      patch :pay_salary
      patch :activate
    end
  end

  resources :filter_ezinvoices, only: [:index, :new]

  resources :invoices, only: [:create, :show, :edit, :update, :destroy] do
    member do
      patch :update
      patch :extend
    end
  end

end
