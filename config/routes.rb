Rails.application.routes.draw do
  root to: 'main#index'
  resources :main, only: [:index, :show]
  resources :users, only: [:index, :show]
  get '/', to: 'main#index'
  post '/timecards/start'  => 'timecards#start', as: :timecards_start
  post '/timecards/finish' => 'timecards#finish', as: :timecards_finish
end
