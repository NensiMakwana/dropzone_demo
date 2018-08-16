Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "products#index"
  resources :products
  # get 'uploadfiles',  'products#uploadfiles'
  post 'uploadfiles'=>'products#upload'

end
