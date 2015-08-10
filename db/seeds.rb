# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Dir['db/jobs/*.md'].each do |path|
  file = File.read(path).strip
  status = Job::PUBLISHED
  status = Job::DASHBOARD if path.starts_with?('db/jobs/00_')
  status = Job::DRAFT if path.starts_with?('db/jobs/01_')
  Job.create!(description: file, status: status)
end
