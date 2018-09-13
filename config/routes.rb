Rails.application.routes.draw do

  get 'videos/show'

  get 'videos/new'

  get 'videos/edit'

  resources :topics do
    resources :videos
  end

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

  post :incoming, to: 'incoming#create'
end
