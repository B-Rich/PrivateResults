# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%W{Chlamydia Gonorrhea Syphilis HIV Trichomoniasis}.each do |infection_name|
  Rails.logger.info("Seeding #{Infection.model_name.human}: #{infection_name}")
  Infection.where(name: infection_name).first_or_create!
end
