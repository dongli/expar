Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  get 'main/index'
  get 'dashboard/admin'

  root 'main#index'

  resources :experiments do
    resources :figures
  end
end
