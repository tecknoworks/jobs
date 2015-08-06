require 'rails_helper'

RSpec.describe Job, type: :model do
  it { expect(subject).to have_many :attachments }
  it { expect(subject).to validate_presence_of :description }

  it 'create job' do
    job = Job.create!(description: "test \n for set \n #title")
    expect(job.title).to eq('test')
  end

  it 'the first line is null' do
    job = Job.create!(description: "\n for set \n #title")
    expect(job.title).to eq('')
  end

  it 'the description is null' do
    begin
      job = Job.create!(description: "")
      expect(job.title).to eq('')
      assert false
    rescue
      assert true
    end
  end

end
