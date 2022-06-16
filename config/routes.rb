Rails.application.routes.draw do
  post '/short_urls/generate' => 'short_urls#generate'
  get '/:url' => 'short_urls#show', as: :short
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
