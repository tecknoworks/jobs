require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:job) { create :job }

  it { expect(subject).to have_many :candidate }

  it { expect(subject).to validate_presence_of :description }
  it { expect(subject).to validate_presence_of :status }

  it 'create job' do
    expect(job.title).to eq('Test')
  end

  it 'the first line is null' do
    job = create :job
    job.update(description: "\n for set \n #title")
    expect(job.title).to eq('')
    expect(job.status).to eq(Job::PUBLISHED)
  end

  it 'default status' do
    job = Job.create!(description: 'test')
    expect(job.status).to eq(Job::DRAFT)
    expect(job.description).to eq('test')
  end

  it 'the description is null' do
    begin
      job = Job.create!(description: '')
      assert false
    rescue
      assert true
    end
  end
end
