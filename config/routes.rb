Rails.application.routes.draw do
  get '/analyze_query/:id', to: 'image_queries#analyze_query', as: 'analyze_query'
  resources :image_queries
  resources :people
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
