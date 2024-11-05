# frozen_string_literal: true

require "spec_helper"

class JobTracker < ActiveRecord::Base; end

if defined? ActiveRecord
  describe Percent::ActiveRecord::MigrationExtensions::SchemaStatements do
    let!(:connection) { ActiveRecord::Base.connection }

    before do
      connection.send :extend, described_class

      if connection.data_source_exists? :job_trackers
        connection.drop_table :job_trackers
      end
      connection.create_table :job_trackers

      connection.add_percentage :job_trackers, :percentage
      connection.add_percentage :job_trackers, :full_options, default: 1, null: true

      JobTracker.reset_column_information
    end

    describe "#add_percentage" do
      context "default options" do
        subject { JobTracker.columns_hash["percentage_fraction"] }

        it "defaults to 0" do
          expect(subject.default).to eql "0.0"
          expect(JobTracker.new.public_send(subject.name)).to eq 0
        end

        it "does not allow null values" do
          expect(subject.null).to be false
        end

        it "is of type decimal" do
          expect(subject.type).to be :decimal
        end
      end

      context "full options" do
        subject { JobTracker.columns_hash["full_options_fraction"] }

        it "defaults to 1" do
          expect(subject.default).to eql "1.0"
          expect(JobTracker.new.public_send(subject.name)).to eq 1
        end

        it "allows null values" do
          expect(subject.null).to be true
        end

        it "is of type decimal" do
          expect(subject.type).to be :decimal
        end
      end
    end

    describe "#remove_percentage" do
      before do
        connection.remove_percentage :job_trackers, :percentage
        connection.remove_percentage :job_trackers, :full_options, default: 1, null: true

        JobTracker.reset_column_information
      end

      it "removes percentage columns" do
        expect(JobTracker.columns_hash["percentage_fraction"]).to be_nil
        expect(JobTracker.columns_hash["full_options_fraction"]).to be_nil
      end
    end
  end
end
