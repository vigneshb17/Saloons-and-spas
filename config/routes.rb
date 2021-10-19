Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :customers, :controllers => { :sessions => 'sessions' }

  namespace :api, defaults: { format: :json } do
    resources :saloons, only: :index do
      member do
        get :services
        post :book_service
        get :booking_reports
      end
    end
  end
end
