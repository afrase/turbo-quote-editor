# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :quotes do
    resources :line_item_dates, except: %i[index show] do
      resources :line_items, except: %i[index show]
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  root to: 'pages#home'
end
