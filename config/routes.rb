Rails.application.routes.draw do
  root to: 'main#index'
  resources :main, only: [:index, :show]
  get '/', to: 'main#index'
  post '/timecards/finish' => 'timecards#finish', as: :timecards_finish

  namespace :admin do
    get '/', to: 'menus#index'
    resources :vendors
    resources :menus
  end

  namespace :api do
    get  '/menu',               to: 'mattermost#menu'
    post '/menus/:id/vote',     to: 'mattermost#vote_on_menu'
  end

end
