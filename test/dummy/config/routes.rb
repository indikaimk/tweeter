Rails.application.routes.draw do
  mount Tweeter::Engine => "/tweeter"
end
