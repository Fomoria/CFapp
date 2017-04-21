Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "user_registrations"}
  resources :users
  resources :products do
    resources :comments
  end
  resources :orders, only: [:index, :show, :create, :destroy]
  
	root 'static_pages#index'

	get 'static_pages/index'

	get 'static_pages/about'

	get 'static_pages/contact'

	get 'static_pages/landing_page'

	post 'static_pages/thank_you'

  post 'payments/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
