# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :talks_speakers do
      primary_key :id

      foreign_key :talk_id, :talks, null: false, on_delete: :cascade
      foreign_key :speaker_id, :speakers, null: false, on_delete: :cascade
    end
  end
end
