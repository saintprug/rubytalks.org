# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :speakers do
      add_column :slug, String, null: false
    end
  end
end
