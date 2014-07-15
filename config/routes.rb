Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  get 'main/index'

  root 'main#index'

  resources :experiments do
    resources :figures
  end
end
