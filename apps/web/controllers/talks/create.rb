# frozen_string_literal: true

module Web
  module Controllers
    module Talks
      class Create
        include Web::Action
        include Dry::Monads::Result::Mixin
        include Import[
          operation: 'talks.operations.create'
        ]

        def call(params)
          form = Web::Forms::TalkForm.new.call(params[:talk])
          if form.success?
            operation.call(form.to_h)
            flash[:success] = 'Talk has been created. It will appear in list when Administrator approves it'
            redirect_to routes.talks_path
          else
            self.body = 'Something wend bad :('
          end
        end
      end
    end
  end
end
