Rails.application.routes.draw do

  devise_for :admins, :skip => [:registrations]
  as :admin do
    get 'admins/edit' => 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins' => 'admins/registrations#update', as: 'admin_registration'
  end
  devise_scope :admin do
    authenticated :admin do
      root to: 'administrations#index'
    end
  end

  devise_for :companies, controllers: {
    registrations: 'companies/registrations',
    sessions: 'companies/sessions',
    confirmations: 'companies/confirmations'
  }
  devise_scope :company do
    authenticated :company do
      root to: 'panels#index'
    end
  end

  devise_for :admin_companies,
    class_name: 'Company',
    only: [],
    controllers: { registrations: 'admin_companies' }

  devise_scope :admin_company do
    get   "/admin_companies/new", to: "admin_companies#new", as: :new_admin_companies
    post  "/admin_companies",    to: "admin_companies#create", as: :admin_companies
    get "/admin_companies/:id", to: "admin_companies#show", as: :admin_company
  end

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    confirmations: 'user/confirmations'
  }
  devise_scope :user do
    patch 'users/:id/verify' => 'users#verify', as: :user_verify
    authenticated :user do
      root to: 'dashboards#index'
    end
  end

  root controller: :index, action: :index

  resources :sign_ups, only: [:index]

  resources :sign_ins, only: [:index]

  resources :our_rates, only: [:index]

  resources :terms_of_services, only: [:index]

  resources :integritypolicies, only: [:index]

  resources :users, only: [:index, :edit, :update, :destroy]

  resources :users_without_profiles, only: [:index]

  resources :companies, only: [:index, :destroy] do
    member do
      patch :verify
    end
  end

  resources :panels, only: [:index]

  resources :payments, only: [:index, :show]

  resources :ezpayments, only: [:show]

  resources :adminpayments, only: [:index, :new]

  resources :admin_applications, only: [:edit, :update, :show]

  resources :howitworks, only: [:index]

  resources :why_us, only: [:index]

  resources :dashboards, only: [:index]

  resources :administrations, only: [:index]

  resources :faqs, only: [:index]

  get 'applications' => 'applications#index', as: :applications

  get 'messages' => 'messages#new'

  post 'messages' => 'messages#create'

  resources :filter_applications, only: [:index]

  resources :hitta_jobb, controller: 'jobs', as: 'jobs', only: [:index, :new, :create, :show, :edit, :update] do
    resources :applications, except: [:index] do
      member do
        patch :clone
        patch :hire
        patch :extend
        patch :revert
      end
      resources :comments, only: [:create]
    end
  end

  resources :categories, only: [:create, :destroy, :edit, :update]

  resources :cities, only: [:create, :destroy, :edit, :update]

  resources :adminjobs, only: [:create, :index, :show, :destroy, :edit, :update]

  resources :profiles, only: [:index, :new, :create, :show, :edit, :update]

  resources :adminprofiles, only: [:index, :destroy, :edit, :update]

  resources :exampleprofiles, only: [:index]

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

  resources :invoices, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      patch :pre_edit
      patch :extend
      patch :feedback
      patch :postal
      patch :rating
    end
  end

end
