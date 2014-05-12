module Insight
  # Encapsulates logic for handling {InfectionTest} and {Result}
  # models in the object graph
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

    # Process infection-related test and results for the row
    # @api public
    # @example
    #  infection_status_processor.process!
    # @return [NotSure] Not Sure
    def process!
      generate_infection_test_results(generate_infection_tests)
    end

    Contract nil => ArrayOf[InfectionTest]
    # Process infection test data
    # @api private
    # @return [Array<InfectionTest>] the created or found {InfectionTest} models
    def generate_infection_tests
      INFECTION_TEST_MAP.values.map do |infection_name|
        Infection.where(name: infection_name).map do |infection|
          if tested_for?(infection_name)
            output = generate_infection_test(visit_id, infection)
          else
            Rails.logger.info("Skipping creating #{InfectionTest.model_name.human.pluralize} for #{infection_name}")
            output = []
          end

          output
        end
      end.flatten
    end

    Contract Num, Infection => InfectionTest
    # Generate an InfectionTest for a given {Infection}
    # @api private
    # @param visit_id [Num] the id of the visit
    # @param infection [Infection] the corresponding infection for which to make the test
    # @return [InfectionTest] new or created record
    def generate_infection_test(visit_id, infection)
      Rails.logger.info("Creating #{InfectionTest.model_name.human.pluralize} for #{infection.name}")

      InfectionTestFactory.new(
        :name         => "#{infection.name} #{InfectionTest.model_name.human}",
        :visit_id     => visit_id,
        :infection_id => infection.id
      ).make!
    end

    Contract ArrayOf[InfectionTest] => ArrayOf[Result]
    # Process InfectionTest records to produce corresponding Result records
    # @api private
    # @param infection_tests [Array<InfectionTest>] persisted InfectionTest records
    # @return [Array<Result>] the constructed or found Result models
    def generate_infection_test_results(infection_tests)
      infection_tests.map do |infection_test|
        positive_for_infection = positive_for?(infection_test.infection.name)

        # check if boolean
        if !!positive_for_infection == positive_for_infection
          output = ResultFactory.new(
            :name => "#{Result.model_name.human} for #{InfectionTest.model_name.human} #{infection_test.infection.name}",
            :infection_test_id => infection_test.id,
            :positive => positive_for_infection,
            :infection_id => infection_test.infection_id,
            :visit_id => infection_test.visit_id
          ).make!
        else
          output = []
        end

        output
      end.flatten
    end

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
