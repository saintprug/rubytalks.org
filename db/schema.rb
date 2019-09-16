Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id
      String :name, text: true, null: false
      String :city, text: true, null: false
      DateTime :started_at
      DateTime :ended_at
      String :state, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_table(:schema_migrations) do
      String :filename, text: true, null: false

      primary_key [:filename]
    end

    create_table(:speakers) do
      primary_key :id
      String :first_name, text: true, null: false
      String :last_name, text: true, null: false
      String :slug, text: true, null: false
      String :state, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_table(:talks) do
      primary_key :id
      foreign_key :event_id, :events, key: [:id]
      String :title, text: true, null: false
      String :description, text: true, null: false
      String :link, text: true, null: false
      String :embed_code, text: true
      String :state, null: false
      DateTime :talked_at, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_table(:talks_speakers, ignore_index_errors: true) do
      primary_key :id
      foreign_key :talk_id, :talks, null: false, key: [:id], on_delete: :cascade
      foreign_key :speaker_id, :speakers, null: false, key: [:id], on_delete: :cascade

      index [:talk_id, :speaker_id], unique: true
    end
  end
end
