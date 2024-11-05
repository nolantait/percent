# frozen_string_literal: true

module Percent
  module Hooks
    module_function

    def init
      ActiveSupport.on_load(:active_record) do
        require "percent/active_model/percentage_validator"
        require "percent/active_record/percentizable"
        ::ActiveRecord::Base.include Percent::ActiveRecord::Percentizable

        require "percent/active_record/migration_extensions/options"
        require "percent/active_record/migration_extensions/schema_statements"
        require "percent/active_record/migration_extensions/table"
        ::ActiveRecord::Migration.include(
          Percent::ActiveRecord::MigrationExtensions::SchemaStatements
        )
        ::ActiveRecord::ConnectionAdapters::TableDefinition.include(
          Percent::ActiveRecord::MigrationExtensions::Table
        )
        ::ActiveRecord::ConnectionAdapters::Table.include(
          Percent::ActiveRecord::MigrationExtensions::Table
        )
      end
    end
  end
end
