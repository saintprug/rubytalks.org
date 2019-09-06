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
          find_talk_operation: 'talks.operations.find',
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
            result = find_talk_operation.call(id: params[:id])
            case result
            when Success
              self.body = Admin::Views::Talks::Edit.render(
                format: :html,
                params: params,
                flash: { error: collect_errors(form_response.messages(full: true)) },
                talk: result.value!
              )
            when Failure
              # TODO: log to rollbar/sentry
              flash[:error] = 'Something wrong. Talk has not been updated'
              redirect_to routes.root_url
            end
          end
        end

        private

        def verify_csrf_token?
          false
        end

        def collect_errors(errors)
          errors.values.flat_map do |value|
            value.respond_to?(:values) ? collect_errors(value) : value
          end
        end
      end
    end
  end
end
