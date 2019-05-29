# frozen_string_literal: true

root to: 'dashboard#index'

resources :approve_talk, only: :update
resources :decline_talk, only: :update
