require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:job) { create :job }

  it { expect(subject).to have_many :attachments }

  it { expect(subject).to validate_presence_of :description }

  it 'create job' do
    expect(job.title).to eq('Test')
  end

  it 'the first line is null' do
    job = create :job
    job.update(description: "\n for set \n #title")
    expect(job.title).to eq('')
    expect(job.status).to eq(Job::PUBLISHED)
  end

  # CODE: please use a factory and improve spec description
  it 'default status' do
    job = Job.create!(description: 'test')
    expect(job.status).to eq(Job::DRAFT)
    expect(job.description).to eq('test')
  end

  # CODE: I am not sure what this test is supposed to do
  #
  # 1. Please improve the spec description
  # 2. Use a factory
  it 'the description is null' do
    begin
      job = Job.create!(description: '')
      assert false
    rescue
      assert true
    end
  end

  it 'only saves alpha numeric characters to the title' do
    job.update(description: "# Hello world\nHello")
    expect(job.title).to eq 'Hello world'
  end
end
