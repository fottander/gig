Rails.application.routes.draw do

  devise_for :companies, controllers: {
  registrations: 'companies/registrations'
}

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'dashboards#index'
    end
  end

  root controller: :index, action: :index

  resources :jobs, only: [:index, :new, :create, :show]

end
