# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :events do
      primary_key :id

      column :name, String, null: false
      column :city, String, null: false

      column :started_at, DateTime
      column :ended_at, DateTime

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
