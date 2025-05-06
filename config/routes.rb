Tweeter::Engine.routes.draw do
  resources :publishers do
    resources :tweets, shallow: true
    resources :accounts, shallow: true
    resources :threads, shallow: true
  end
  

end
