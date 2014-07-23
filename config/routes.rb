Rails.application.routes.draw do
  devise_for :users,
    path_prefix: 'd',
    controllers: { registrations: 'registrations' }

  get 'main/index'
  get 'dashboard/admin'

  root 'main#index'

  resources :users
  get 'users/:id/change_password', to: 'users#change_password', as: 'change_password'

  resources :components
  resources :models

  resources :experiments, shallow: true do
    resources :diags do
      resources :figures
    end
  end
end
