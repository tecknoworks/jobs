Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  apipie
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope :api, defaults: { format: :json } do
    put '/login', to: 'users#login'
    resources :jobs, only: [:index, :show, :create, :destroy, :update]
    resources :candidates, only: [:index, :show, :create, :destroy, :update]
    resources :interviews, only: [:index, :show, :create, :destroy]
    resources :attachments, only: [:index, :show, :create, :destroy]
  end

  post 'test_ldap_auth', to: 'tkw_auth_tests#create' if Rails.env.test?

  get '/*path' => redirect('/?goto=%{path}')
end
