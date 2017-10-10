Rails.application.routes.draw do
  
  devise_for :companies, controllers: {
  registrations: 'companies/registrations'
}

  devise_for :users

  root controller: :index, action: :index

end
