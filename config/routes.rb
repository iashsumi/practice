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

  resources :books do
    collection do
      post 'new_confirm'
    end
    member do
      patch 'edit_confirm'
    end
  end

  resources :authors do
    collection do
      post 'new_confirm'
    end
    member do
      patch 'edit_confirm'
    end
  end

  resources :lending_datum do
    collection do
      get 'books'
      get 'new_header'
      post 'new_book_select'
      post 'new_confirm'
      post 'add_book'
    end
    member do
      patch 'edit_confirm'
      delete 'delete_book'
    end
  end

  resources :publishers do
    collection do
      post 'new_confirm'
    end
    member do
      patch 'edit_confirm'
    end
  end

  resources :active_strage_practices do
    collection do
      post 'new_confirm'
    end
  end
end
