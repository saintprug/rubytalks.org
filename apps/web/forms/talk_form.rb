# frozen_string_literal: true

module Web
  module Forms
    class TalkForm
      SpeakerSchema = Dry::Validation.Form do
        required(:first_name).filled(:str?)
        required(:last_name).filled(:str?)
      end

      EventSchema = Dry::Validation.Form do
        required(:name).filled(:str?)
        required(:city).filled(:str?)
        required(:started_at).filled(:str?)
        required(:ended_at).filled(:str?)
      end

      TalkSchema = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:description).filled(:str?)
        required(:talked_at).filled(:date_time?)
        required(:link).filled(:str?)
        required(:speaker).schema(SpeakerSchema)
        required(:event).schema(EventSchema)
      end

      def call(params)
        TalkSchema.call(params)
      end
    end
  end
end
