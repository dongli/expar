Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd', :controllers => { registrations: 'registrations' }

  get 'main/index'
  get 'dashboard/admin'

  root 'main#index'

  resources :users

  resources :experiments, shallow: true do
    resources :diags do
      resources :figures
    end
  end
end
