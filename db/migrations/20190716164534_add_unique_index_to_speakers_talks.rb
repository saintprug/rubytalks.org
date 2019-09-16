# frozen_string_literal: true

Sequel.migration do
  up do
    alter_table :talks_speakers do
      add_index %i[talk_id speaker_id], unique: true
    end
  end

  down do
    alter_table :talks_speakers do
      drop_index %i[talk_id speaker_id]
    end
  end
end
