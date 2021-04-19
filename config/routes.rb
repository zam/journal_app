Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root :to => 'home#index'
  
  get 'tasks/today', as: 'today'
  get 'tasks/completed_tasks', as: 'completed_tasks'
  resources :categories
  resources :tasks do
    patch :complete
  end
  
end
