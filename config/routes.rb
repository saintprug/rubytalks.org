# frozen_string_literal: true

Hanami.application.routes do
  mount :admin_api, at: '/admin' do
    root to: 'home#index'

    resources :talks, only: [:update] do
      collection do
        get :unpublished
      end

      member do
        post :approve
        post :decline
      end
    end

    resources :speakers, only: [:update]
    resources :events, only: [:update]
  end
end
