# frozen_string_literal: true

root to: 'dashboard#index'

resources :talks, only: %i[update edit] do
  member do
    patch 'approve'
    patch 'decline'
  end
end
