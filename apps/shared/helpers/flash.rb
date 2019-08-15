# frozen_string_literal: true

module Shared
  module Helpers
    module Flash
      def show_flash(flash)
        if flash[:success]
          success_message(flash[:success])
        elsif flash[:error]
          flash[:error].map do |error_message|
            error_message(error_message)
          end.map(&:to_s).join("\n")
        end
      end

      private

      def success_message(text)
        html.div(class: 'alert alert-success alert-dismissible fade show', role: 'alert') do
          text(text)
          button(class: 'close', 'aria-label' => 'Close', 'data-dismiss' => 'alert', type: 'button') do
            span('aria-hidden' => 'true') { raw('&times;') }
          end
        end
      end

      def error_message(text)
        html.div(class: 'alert alert-danger alert-dismissible fade show', role: 'alert') do
          text(text)
          button(class: 'close', 'aria-label' => 'Close', 'data-dismiss' => 'alert', type: 'button') do
            span('aria-hidden' => 'true') { raw('&times;') }
          end
        end
      end
    end
  end
end
