# frozen_string_literal: true

Sequel.migration do
  up do
    execute "CREATE TYPE state AS ENUM ('unpublished', 'approved', 'declined');"

    create_table :speakers do
      primary_key :id

      column :first_name, String, null: false
      column :last_name, String, null: false
      column :slug, String, null: false
      column :state, :state, null: false, default: 'unpublished'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do
    drop_table :speakers

    run 'DROP TYPE IF EXISTS "state"'
  end
end
