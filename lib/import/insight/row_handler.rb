# INSIGHT data import components
module Insight
  # Cover handling a single Insight CSV row
  class RowHandler
    include Contracts
    include ActiveModel::Model

    attr_accessor :row_hash

    Contract nil => Patient
    # Handle this row
    # @api public
    # @example
    #  row_handler.run!
    # @return [Patient] object graph starting with Patient
    def run!
      Rails.logger.tagged('Insight::RowHandler') do
        patient = make_patient(row_hash)
        visit = make_visit(row_hash, patient.id)
        infection_tests = make_infection_tests(row_hash, visit.id)

        patient
      end
    end

    Contract Hash, Num => ArrayOf[InfectionTest]
    # Create or return {InfectionTest} records from row
    # @api private
    # @param row [Hash] hash containing row data
    # @param visit_id [Fixnum] id of associated visit record
    # @return [Array<Patient>] new or existing InfectionTest records
    def make_infection_tests(row, visit_id)
      Insight::InfectionStatusProcessor.new(row_hash: row, visit_id: visit_id).process!
    end

    Contract Hash => Patient
    # Construct or return {Patient} record from row
    # @api private
    # @param row [Hash] hash containing row data
    # @return [Patient] new or existing Patient record
    def make_patient(row)
      PatientFactory.new(patient_number: row[:patient_no]).make!
    end

    Contract Hash, Num => Visit
    # Construct or return {Visit} record from row
    # @api private
    # @param row [Hash] hash containing row data
    # @param patient_id [Fixnum] DB id of corresponding {Patient}
    # @return [Visit] new or existing Patient record
    def make_visit(row, patient_id)
      transform_map = [:visit_date,
                       :cosite,
                       :sex,
                       :race,
                       :zip_code,
                       :sexualpref,
                       :sexualidentity,
                       :age,
                       :partners_last_6_months_5_or_more].map {|e| {e => e} }.reduce(&:merge)

      attributes = map_keys(row, transform_map).merge(patient_id: patient_id)

      VisitFactory.new(attributes).make!
    end

    Contract Hash, Hash => Hash
    # Rekey hash according to transformation map
    # @api private
    # @param input_hash [Hash] original data
    # @param transform_map [Hash] specify :source_key => :dest_key
    # @return [Hash] the transformed hash
    def map_keys(input_hash, transform_map)
      transform_map.map {|key, val| {val => input_hash.fetch(key)} }.reduce(&:merge)
    end
  end
end
