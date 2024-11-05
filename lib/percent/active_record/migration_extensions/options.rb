module Percent
  module ActiveRecord
    module MigrationExtensions
      module Options
        def self.without_table(accessor, null: false, default: 0)
          field = accessor.to_s.gsub("_fraction", "")
          column_name = "#{field}_fraction"

          [column_name, :decimal, { null:, default: }]
        end

        def self.with_table(table_name, accessor, **options)
          column_name, type, options = without_table(accessor, **options)

          [table_name, column_name, type, options]
        end
      end
    end
  end
end
