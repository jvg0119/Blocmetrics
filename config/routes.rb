Rails.application.routes.draw do
	
  devise_for :users
  resources :users, only: [:update]
  #post 'update' => 'users#update'
  get 'index' => 'welcome#index'
  get 'about' => 'welcome#about'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
