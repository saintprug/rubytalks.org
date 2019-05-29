# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :talks do
      add_column :embed_code, String
      add_column :published, TrueClass, null: false, default: false
    end
  end
end
