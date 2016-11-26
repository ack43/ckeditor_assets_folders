Ckeditor::Engine.routes.draw do
  resources :folders, only: [:index, :show, :create, :destroy]
end
