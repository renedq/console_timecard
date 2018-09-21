Rails.application.routes.draw do
  devise_for :users
  root to: 'units#index'
  resources :units, only: [:index, :show, :edit, :new]
  resources :users, only: [:index, :show, :edit, :new]
  resources :timecards #, only: [:show, :edit, :delete]

  post '/timecards/start'  => 'timecards#start', as: :timecards_start
  post '/timecards/finish' => 'timecards#finish', as: :timecards_finish

  namespace :admin do
    get '/', to: 'units#index'
    resources :units
    resources :users
  end

	#todo delete this?
  namespace :super_admin do
    get '/', to: 'units#index'
    resources :users
    resources :units
  end
end
