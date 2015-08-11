require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { expect(subject).to belong_to :candidate }
  it { expect(subject).to belong_to :user }

  it { expect(subject).to validate_presence_of :user }
  it { expect(subject).to validate_presence_of :file }
  it { expect(subject).to validate_presence_of :candidate }

  let(:attachment) { create :attachment }

  it 'works' do
    expect do
      create :attachment
    end.to change { Attachment.count }.by 1
  end

  it 'works' do
    candidate = create :candidate
    user = create :user
    attachment = create :attachment, candidate_id: candidate.id, user_id: user.id
    expect(attachment.candidate_id).to eq(candidate.id)
    expect(attachment.user_id).to eq(user.id)
  end

  it 'attachment by default = 0' do
    candidate = create :candidate
    user = create :user
    attachment = create :attachment, candidate_id: candidate.id, user_id: user.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf')
  end
end
