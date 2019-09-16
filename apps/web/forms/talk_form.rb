# frozen_string_literal: true

require 'hanami/utils/blank'

module Web
  module Forms
    class TalkForm
      SpeakerSchema = Dry::Validation.Form do
        optional(:id).filled(:int?)
        required(:first_name).filled(:str?)
        required(:last_name).filled(:str?)
      end

      EventSchema = Dry::Validation.Form do
        optional(:id)
        required(:name).filled(:str?)
        required(:city).filled(:str?)
        required(:started_at).filled(:time?)
        required(:ended_at).filled(:time?)
      end

      TalkSchema = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:description).filled(:str?)
        required(:talked_at).filled(:time?)
        required(:link).filled(:str?)
        required(:speakers).each(SpeakerSchema)
        optional(:event).schema(EventSchema)
      end

      def call(params)
        # not sure this is appropriate place
        params.delete(:event) if params[:event]&.values&.all? { |value| Hanami::Utils::Blank.blank?(value) }
        TalkSchema.call(params)
      end
    end
  end
end
