Rails.application.routes.draw do
  #root to: 'units#index'
  resources :units, only: [:index, :show, :edit, :new]
  resources :users, only: [:index, :show, :edit, :new]
  resources :timecards #, only: [:show, :edit, :delete]

  #get '/', to: 'main#index'
  post '/timecards/start'  => 'timecards#start', as: :timecards_start
  post '/timecards/finish' => 'timecards#finish', as: :timecards_finish
end
