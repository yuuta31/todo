Rails.application.routes.draw do
  resources :posts, only: %i[index create show update destroy]
end
