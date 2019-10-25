# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :talks do
      primary_key :id
      # it is possible to save talks without an event
      foreign_key :event_id, :events

      column :title, String, null: false
      column :description, String, null: false
      column :link, String, null: false
      column :embed_code, String
      column :state, :state, null: false, default: 'unpublished'
      column :talked_at, DateTime, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
