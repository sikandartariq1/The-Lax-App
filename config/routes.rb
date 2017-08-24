Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations",
                                  omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :old_salts

  resources :old_salts, only: [:index, :show, :edit, :update] do
    resources :appointments, only: [:index, :show, :new, :create, :edit]
    resources :feedbacks, only: [:show, :index]
    resource :bank_account, only: [:new, :create, :edit, :update, :show]
    resources :payments, only: [:index]
  end

  as :user do
    get "user/edit_profile", to: "registrations#edit"
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resources :appointments, only: [:index, :show]
    resources :feedbacks, only: [:show, :index, :new, :create]
    resources :payments, only: [:index, :new, :create, :edit, :update] do
      get 'update_status', on: :member
    end
  end
  root 'old_salts#index'
end
