# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

previous_experiences = [
  'Never taken a lesson before.',
  'Taken a group lesson previously.',
  'Taken a private lesson previously.',
  'Skied (snowboarded) a total of 3 times or less.',
  'Skied (snowboarded) between 4 and 10 times.',
  'Skied (snowboarded) more than 10 days.'
]

previous_experiences.each do |previous_experience|
  PreviousExperience.create(name: previous_experience)
end