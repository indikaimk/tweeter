Tweeter::Engine.routes.draw do
  resources :publishers do
    resources :tweets, only: [:index, :new, :create]
    resources :accounts, shallow: true
    resources :threads, shallow: true
  end
  
  resources :tweets, only: [:show, :edit, :update, :destroy] do
    member do
      get "publish" #post to twitter settings
    end
  end

  # resources :threads, only: [:show, :edit, :update, :destroy] do
  #   # member do
  #   #   get "publish" #post to twitter settings
  #   # end
  # end
end
