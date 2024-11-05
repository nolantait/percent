module Percent
  module ActiveRecord
    module MigrationExtensions
      module Table
        def percentage(accessor, **)
          name, type, options = Options.without_table(accessor, **)
          column(name, type, **options)
        end

        def remove_percentage(accessor, **)
          *opts = Options.without_table(accessor, **)
          remove(*opts)
        end
      end
    end
  end
end
