# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :talks_speakers do
      add_index %i[talk_id speaker_id], unique: true
    end
  end
end
