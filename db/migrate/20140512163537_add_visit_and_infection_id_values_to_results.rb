class AddVisitAndInfectionIdValuesToResults < ActiveRecord::Migration
    def up
    Result.transaction do
      infection_test_ids = Result.where(visit_id: nil).pluck(:infection_test_id)

      say_with_time "Setting #{Visit.model_name.human} ids" do
        InfectionTest
          .where(id: infection_test_ids)
          .pluck(:id, :infection_id, :visit_id)
          .uniq
          .each_slice(10_000) do |slice|
          say_with_time "Setting ids for #{slice.count} records" do
            slice.each do |pair|
              Result
                .where(infection_test_id: pair.first)
                .update_all(visit_id: pair.last, infection_id: pair[1])
            end
          end
        end
      end
    end
  end

  def down
    Result.transaction do
      Result.where.not(visit_id: nil).update_all(visit_id: nil)
      Result.where.not(infection_id: nil).update_all(infection_id: nil)
    end
  end
end
