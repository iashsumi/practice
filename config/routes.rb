Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      post 'new_confirm'
      get 'new_all'
      post 'import'
    end
    member do
      patch 'edit_confirm'
    end
  end
end
