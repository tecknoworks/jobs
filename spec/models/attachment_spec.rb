require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { expect(subject).to belong_to :job }

  it { expect(subject).to validate_presence_of :job }
  it { expect(subject).to validate_presence_of :status }
  it { expect(subject).to validate_presence_of :file }

  let(:attachment) { create :attachment }

  it 'works' do
    expect do
      create :attachment
    end.  to change{ Attachment.count }.by 1
  end

  it 'works' do
    job = create :job
    attachment = create :attachment, job_id: job.id, status: Attachment::FAIL
    expect(attachment.job_id).to eq(job.id)
    expect(attachment.status).to eq(Attachment::FAIL)
  end

  it 'attachment by default = 0' do
    job = create :job
    attachment = Attachment.create!(job_id: job.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf'))
    expect(attachment.status).to eq(Attachment::PENDING)
  end

end
