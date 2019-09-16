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
          form = Form.new(:talk, routes.talks_path, talk: { speakers: [Speaker.new] })

          form_for form do
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
            end

            div 'Speakers', class: 'h6'
            fields_for_collection :speakers do
              div class: 'form-row' do
                div class: 'col form-group' do
                  text_field :first_name, class: 'form-control', placeholder: 'Speaker first name'
                end
                div class: 'col form-group' do
                  text_field :last_name, class: 'form-control', placeholder: 'Speaker last name'
                end
              end
            end
            div 'Event', class: 'h6'
            div class: 'form-row' do
              fields_for :event do
                div class: 'col form-group' do
                  text_field :name, class: 'form-control', placeholder: 'Event title'
                end
                div class: 'col form-group' do
                  text_field :city, class: 'form-control', placeholder: 'Event city'
                end
                div class: 'col form-group' do
                  text_field :started_at, class: 'form-control', placeholder: 'Event started at'
                end
                div class: 'col form-group' do
                  text_field :ended_at, class: 'form-control', placeholder: 'Event ended at'
                end
              end
            end
            submit submit_label, class: 'btn btn-primary'
          end
        end

        def submit_label
          'Create talk'
        end
      end
    end
  end
end
