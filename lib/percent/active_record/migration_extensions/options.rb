module Percent
  module ActiveRecord
    module MigrationExtensions
      module Options
        def self.without_table(accessor, null: false, default: 0)
          field = accessor.to_s.gsub("_fraction", "")
          column_name = "#{field}_fraction"

          [column_name, :decimal, { null: null, default: default }]
        end

        def self.with_table(table_name, accessor, **options)
          options = without_table accessor, **options
          options.unshift table_name
        end
      end
    end
  end
end
