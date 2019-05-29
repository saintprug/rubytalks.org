# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :talks do
      add_column :talked_at, DateTime, null: false
    end
  end
end
