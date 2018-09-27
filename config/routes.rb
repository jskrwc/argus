Rails.application.routes.draw do

  get 'videos/show'

  get 'videos/new'

  get 'videos/edit'

  resources :topics do
    resources :videos, except: [:index]
  end

  resources :videos, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end



  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

  post :incoming, to: 'incoming#create'
end
