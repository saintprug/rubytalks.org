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

        def call(params)
          form_response = form.call(params[:talk])
          if form_response.success?
            operation.call(form_response.to_h)
            flash[:success] = 'Talk has been created. It will appear in list when Administrator approves it'
            redirect_to routes.talks_path
          else
            self.body = 'Something went bad :('
          end
        end
      end
    end
  end
end
