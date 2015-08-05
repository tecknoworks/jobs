require 'rails_helper'

RSpec.describe Job, type: :model do
  it { expect(subject).to have_many :attachments }
  it { expect(subject).to validate_presence_of :description }

  it 'create job' do
    job = Job.create!(description: "test \n for set \n #title")
    expect(job.title).to eq('test')
  end
end
