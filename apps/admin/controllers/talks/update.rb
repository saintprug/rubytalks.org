# frozen_string_literal: true

module Admin
  module Controllers
    module Talks
      class Update
        include Admin::Action
        include Dry::Monads::Result::Mixin
        include Import[
          talk_repo: 'repositories.talk',
          operation: 'talks.operations.update',
          form: 'web.forms.talk_form'
        ]

        def call(params) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          form_response = form.call(params[:talk])
          if form_response.success?
            result = operation.call(params[:id], form_response.to_h)
            case result
            when Success
              flash[:success] = 'Talk has been updated'
            when Failure
              # TODO: log to rollbar/sentry
              flash[:error] = 'Something wrong. Talk has not been updated'
            end
            redirect_to routes.root_url
          else
            talk = talk_repo.root.combine(:speakers, :event).by_pk(params[:id]).one!
            self.body = Admin::Views::Talks::Edit.render(
              format: :html,
              params: params,
              flash: { error: collect_errors(form_response.messages(full: true)) },
              talk: talk
            )
          end
        end

        private

        def verify_csrf_token?
          false
        end

        def collect_errors(errors)
          errors.values.map do |value|
            value.respond_to?(:values) ? collect_errors(value) : value
          end.flatten
        end
      end
    end
  end
end
