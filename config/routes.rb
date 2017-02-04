Rails.application.routes.draw do
  resources :market_values do 
  	collection do
  		get "calculator"
  		post "result"
  	end
  end
  devise_for :users
  root "market_values#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
