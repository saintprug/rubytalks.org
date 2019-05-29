# frozen_string_literal: true

module Web
  module Views
    module Talks
      class New
        include Web::View

        def title
          'Add Talk'
        end

        def form
          form_for :talk, routes.talks_path do
            div class: 'form-row' do
              div class: 'col form-group' do
                text_field :title, class: 'form-control', placeholder: 'Title'
              end
              div class: 'col form-group' do
                datetime_field :talked_at, class: 'form-control', placeholder: 'Date of talk'
              end
            end
            div class: 'form-row' do
              div class: 'col form-group' do
                text_area :description, class: 'form-control', placeholder: 'Description'
              end
            end
            div class: 'form-row' do
              div class: 'col form-group' do
                text_field :link, class: 'form-control', placeholder: 'Link from Youtube, Vimeo, etc.'
              end
              fields_for :speaker do
                div class: 'col form-group' do
                  text_field :name, class: 'form-control', placeholder: 'Speaker name'
                end
              end
            end
            submit 'Create', class: 'btn btn-primary'
          end
        end
      end
    end
  end
end
