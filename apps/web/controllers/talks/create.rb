# frozen_string_literal: true

module Web
  module Controllers
    module Talks
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.create',
          form: 'web.forms.talk_form'
        ]

        def call(params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          form_response = form.call(params[:talk])
          if form_response.success?
            result = operation.call(form_response.to_h)
            if result.success?
              flash[:success] = 'Talk has been created. It will appear in the list when Administrator approves it'
            else
              # TODO: log to rollbar/sentry
              flash[:error] = 'Something wrong'
            end
            redirect_to routes.talks_path
          else
            self.body = Web::Views::Talks::New.render(
              format: :html,
              params: {},
              flash: { errors: form_response.errors }
            )
          end
        end
      end
    end
  end
end
