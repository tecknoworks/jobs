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

candidate1 = Candidate.create!(job_id: 2, full_name: 'Ghita', phone_number: '0745454545', email: 'ghita@example.com')
candidate2 = Candidate.create!(job_id: 2, full_name: 'Alexandru', phone_number: '0722222222', email: 'alexandru@example.com')
candidate3 = Candidate.create!(job_id: 3, full_name: 'Ioana', phone_number: '0733333333', email: 'ioana@example.com')
candidate4 = Candidate.create!(job_id: 2, full_name: 'Andreea', phone_number: '0744444444', email: 'andreea@example.com')

Attachment.create!(user_id: user1.id, candidate_id: candidate1.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user_id: user1.id, candidate_id: candidate2.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user_id: user1.id, candidate_id: candidate3.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user_id: user2.id, candidate_id: candidate4.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
Attachment.create!(user_id: user1.id, candidate_id: candidate1.id, file: Rack::Test::UploadedFile.new('spec/text.pdf'))

Interview.create!(candidate_id: candidate1.id, user_id: user1.id, status: 1)
Interview.create!(candidate_id: candidate1.id, user_id: user2.id, status: 1)
Interview.create!(candidate_id: candidate1.id, user_id: user3.id, status: 1)
Interview.create!(candidate_id: candidate1.id, user_id: user4.id, status: 0)

Interview.create!(candidate_id: candidate2.id, user_id: user1.id, status: 0)
Interview.create!(candidate_id: candidate2.id, user_id: user4.id, status: 0)

Interview.create!(candidate_id: candidate3.id, user_id: user2.id, status: 1)
Interview.create!(candidate_id: candidate3.id, user_id: user1.id, status: 0)
