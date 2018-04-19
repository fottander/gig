Rails.application.routes.draw do

  devise_for :admins
  devise_scope :admin do
    authenticated :admin do
      root to: 'administrations#index'
    end
  end

  devise_for :companies, controllers: {
    registrations: 'companies/registrations',
    sessions: 'companies/sessions'
  }
  devise_scope :company do
    authenticated :company do
      root to: 'panels#index'
    end
  end

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }
  devise_scope :user do
    authenticated :user do
      root to: 'dashboards#index'
    end
  end

  root controller: :index, action: :index

  resources :our_rates, only: [:index]

  resources :terms_of_services, only: [:index]

  resources :users, only: [:index, :destroy]

  resources :users_without_profiles, only: [:index]

  resources :companies, only: [:index, :destroy]

  resources :panels, only: [:index]

  resources :payments, only: [:index, :show]

  resources :ezpayments, only: [:show]

  resources :adminpayments, only: [:index, :new]

  resources :howitworks, only: [:index]

  resources :dashboards, only: [:index]

  resources :administrations, only: [:index]

  get 'applications' => 'applications#index', as: :applications

  get 'messages' => 'messages#new'

  post 'messages' => 'messages#create'

  resources :filter_applications, only: [:index]

  resources :jobs, only: [:index, :new, :create, :show, :edit, :update] do
    resources :applications, except: [:index] do
      member do
        patch :hire
        patch :extend
      end
      resources :comments, only: [:create]
    end
  end

  resources :categories, only: [:create, :destroy, :edit, :update]

  resources :cities, only: [:create, :destroy, :edit, :update]

  resources :adminjobs, only: [:index, :show, :destroy]

  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]

  resources :adminprofiles, only: [:index, :destroy]

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
      patch :extend
      patch :feedback
      patch :postal
      patch :rating
    end
  end

end
