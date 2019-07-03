# frozen_string_literal: true

module Admin
  module Views
    module Dashboard
      class Index
        include Admin::View
        # TODO: add pagination
        # include Hanami::Pagination::View

        def title
          'Admin dashboard'
        end

        def approve_button(id)
          html.form(action: routes.approve_talk_path(id), method: 'POST') do
            input(type: 'hidden', name: '_method', value: 'PATCH')
            input(type: 'submit', value: 'Approve', class: 'btn btn-success')
          end
        end

        def decline_button(id)
          html.form(action: routes.decline_talk_path(id), method: 'POST') do
            input(type: 'hidden', name: '_method', value: 'PATCH')
            input(type: 'submit', value: 'Decline', class: 'btn btn-danger')
          end
        end

        def format_date(date)
          date.strftime('%d.%m.%Y')
        end
      end
    end
  end
end
