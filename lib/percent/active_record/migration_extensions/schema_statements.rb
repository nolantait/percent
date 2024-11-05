# frozen_string_literal: true

module Percent
  module ActiveRecord
    module MigrationExtensions
      module SchemaStatements
        def add_percentage(table_name, accessor, **)
          table_name, column_name, type, options = Options.with_table(
            table_name,
            accessor,
            **
          )
          add_column(table_name, column_name, type, **options)
        end

        def remove_percentage(table_name, accessor, **)
          table_name, column_name, type, options = Options.with_table(
            table_name,
            accessor,
            **
          )
          remove_column(table_name, column_name, type, **options)
        end
      end
    end
  end
end
