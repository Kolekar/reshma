Rails.application.routes.draw do
  resources :users
  # devise_for :users
  devise_for :dairies
  get 'reports/member'
  get 'reports/daily'
  get 'reports/member_collection'
  get 'reports/dairy'
  get 'reports/all_member'
  get 'reports/user'

  resources :rates
  resources :collections

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
