Dir['db/jobs/*.md'].each do |path|
  file = File.read(path).strip
  status = Job::PUBLISHED
  status = Job::DASHBOARD if path.starts_with?('db/jobs/00_')
  status = Job::DRAFT if path.starts_with?('db/jobs/01_')
  Job.create!(description: file, status: status)
end

user1 = User.create!(email: 'ionut@example.com', password: 'password')
user2 = User.create!(email: 'catalin@example.com', password: 'password')
user3 = User.create!(email: 'test@example.com', password: 'password')
user4 = User.create!(email: 'foo@example.com', password: 'password')

candidate1 = Candidate.create!(job_id: 1, full_name: 'Ghita', phone_number: '0745454545', email: 'ghita@example.com', source: 'Jobs.com')
candidate2 = Candidate.create!(job_id: 1, full_name: 'Alexandru', phone_number: '0722222222', email: 'alexandru@example.com', source: 'employee')
candidate3 = Candidate.create!(job_id: 3, full_name: 'Ioana', phone_number: '0733333333', email: 'ioana@example.com', source: 'employee')
candidate4 = Candidate.create!(job_id: 2, full_name: 'Andreea', phone_number: '0744444444', email: 'andreea@example.com', source: 'employee')

Attachment.create!(user: user1, candidate: candidate1, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user: user1, candidate: candidate2, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user: user1, candidate: candidate3, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user: user2, candidate: candidate4, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user: user1, candidate: candidate1, file: Rack::Test::UploadedFile.new('spec/text.pdf'))

Interview.create!(candidate: candidate1, user: user1, date_and_time: '10/10/2015 12:20')
Interview.create!(candidate: candidate1, user: user2, date_and_time: '10/10/2015 12:20')
Interview.create!(candidate: candidate1, user: user3, date_and_time: '10/10/2015 12:20')
Interview.create!(candidate: candidate1, user: user4, date_and_time: '10/10/2015 12:20')

Interview.create!(candidate: candidate2, user: user1, date_and_time: '10/10/2015 12:20')
Interview.create!(candidate: candidate2, user: user4, date_and_time: '10/10/2015 12:20')

Interview.create!(candidate: candidate3, user: user2, date_and_time: '10/10/2015 12:20')
Interview.create!(candidate: candidate3, user: user1, date_and_time: '10/10/2015 12:20')
