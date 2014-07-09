# Generates {Visit} model from supplied data. Idempotent.
# @api public
class VisitFactory
  include Contracts
  include ActiveModel::Model

  # Defines the parsable date format for visited_on (visit_date)
  # @api private
  # @return [String] the format string
  DATE_FORMAT_STRING = '%d %b %y'

  attr_accessor :patient_id, :visit_date, :cosite, :sex, :race, :zip_code, :sexualpref, :sexualidentity, :age, :partners_last_6_months_5_or_more, :username, :password

  Contract nil => Visit
  # Constructs model
  # @api public
  # @example
  #  visit_factory.make!
  # @return [Visit] the created visit
  def make!
    Rails.logger.tagged("VisitFactory") do
      Visit
        .where(:patient_id => patient_id,
               :visited_on => parsed_visit_date(visit_date),
               :cosite => cosite)
        .first_or_create!(:sex                              => sex,
                          :race                             => race,
                          :zip_code                         => zip_code,
                          :sexual_preference                => sexualpref,
                          :sexual_identity                  => sexualidentity,
                          :age                              => parsed_age(age),
                          :partners_last_6_months_5_or_more => partners_last_6_months_5_or_more,
                          :phone_user_number                => username.to_i,
                          :phone_password_number            => password.to_i)
    end
  end

  Contract String => Date
  # Convert raw date string to a Ruby Date object
  # @api private
  # @param date_string [String] raw date string in DD-Mon-YY format
  # @return [Date] the converted Ruby Date object
  def parsed_visit_date(date_string)
    Rails.logger.info("Attempting to parse #{date_string}")
    Date.strptime(date_string, DATE_FORMAT_STRING)
  end

  Contract Maybe[String] => Maybe[Num]
  # Convert raw age string to number
  # @api private
  # @param age_string [String,nil] raw age string
  # @return [Fixnum,nil] age as a Ruby number
  def parsed_age(age_string)
    age_string.to_i
  end
end
