# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :talks_speakers do
      primary_key :id

      foreign_key :talk_id, :talks, null: false, on_delete: :cascade
      foreign_key :speaker_id, :speakers, null: false, on_delete: :cascade
    end
  end

  down do
    drop_table :talks_speakers
  end
end
