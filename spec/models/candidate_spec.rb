require 'rails_helper'

RSpec.describe Candidate, type: :model do
  let(:candidate) { create :candidate }

  it { expect(subject).to have_many :attachments }
  it { expect(subject).to belong_to :job }

  it { expect(subject).to validate_presence_of :full_name }
  it { expect(subject).to validate_presence_of :phone_number }
  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_presence_of :job }

  it 'work' do
    expect do
      candidate
    end.to change {Candidate.count}.by 1
  end

  it 'create candidate' do
    job = Job.create!(description: 'test')
    candidate = create :candidate, job_id: job.id
    expect(candidate.job_id).to eq(job.id)
    expect(candidate.phone_number).to eq('0755555555')
    expect(candidate.email).to eq('email@example.com')
    expect(candidate.full_name).to eq('Full Name')
  end
end
