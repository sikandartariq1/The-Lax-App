Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: "registrations"}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :old_salts

  resources :old_salts, only: [:index, :show, :edit, :update] do
    resources :appointments, only: [:index]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resources :appointments, only: [:index]
  end

  root 'old_salts#index'
end
