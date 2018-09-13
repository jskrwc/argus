Rails.application.routes.draw do

  get 'videos/show'

  get 'videos/new'

  get 'videos/edit'

  resources :topics do
    resources :videos
  end

  get 'topics/index'

  get 'topics/show'

  get 'topics/new'

  get 'topics/edit'

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
