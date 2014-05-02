module Insight
  # Encapsulates logic for handling {InfectionTest} and {Result}
  # models in the object graph
  #
  # @api private
  class InfectionStatusProcessor
    include Contracts
    include ActiveModel::Model

    attr_accessor :row_hash, :visit_id

    # @api private
    INFECTION_TEST_MAP = {
      :cttested    => 'Chlamydia',
      :gctested    => 'Gonorrhea',
      :hivtested   => 'HIV',
      :trichtested => 'Trichomoniasis',
      :syphtested  => 'Syphilis'
    }

    # @api private
    INFECTION_RESULT_MAP = {
      :ctresult    => 'Chlamydia',
      :gcresult    => 'Gonorrhea',
      :hivresult   => 'HIV',
      :trichresult => 'Trichomoniasis',
      :syphresult  => 'Syphilis'
    }

    Contract String => Bool
    # Determine if the patient on this visit was tested for a given infection
    # @api private
    # @param infection_name [String] the name of the infection
    # @return [Bool] wherer or not the patient was tested
    def tested_for?(infection_name)
      key = INFECTION_TEST_MAP.invert.fetch(infection_name)

      boolify_value(row_hash.fetch(key))
    end

    Contract String => Maybe[Bool]
    # Determine if the patient on this visit tested positive for a given infection
    # @api private
    # @param infection_name [String] the name of the infection
    # @return [Bool] wherer or not the patient tested positive
    def positive_for?(infection_name)
      key = INFECTION_RESULT_MAP.invert.fetch(infection_name)

      boolify_value(row_hash.fetch(key))
    end

    Contract Maybe[String] => Maybe[Bool]
    def boolify_value(value)
      if value.nil?
        nil
      else
        value.to_s.to_i == 1
      end
    end
  end
end
