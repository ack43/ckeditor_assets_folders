Ckeditor::Engine.routes.draw do
  resources :folders, only: [:index, :show, :create, :destroy] do
    post :insert_into, on: :member
    post :insert_asset, on: :collection
  end
end
