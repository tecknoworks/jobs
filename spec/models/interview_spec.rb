require 'rails_helper'

RSpec.describe Interview, type: :model do
  let(:interview) { create :interview }
  let(:interview_with_invalid_status) { create :interview_with_invalid_status }

  it { expect(subject).to belong_to :candidate }
  it { expect(subject).to belong_to :user }

  it { expect(subject).to validate_presence_of :candidate }
  it { expect(subject).to validate_presence_of :status }
  it { expect(subject).to validate_presence_of :user }
  it { expect(subject).to validate_presence_of :date_and_time }

  it 'works' do
    expect(interview).to be_valid
  end

  it 'status is not included in the list' do
    expect do
      interview_with_invalid_status
    end.to raise_error ActiveRecord::RecordInvalid
  end

  it 'create interview' do
    candidate = create :candidate
    user = create :user
    expect do
      @interview = create :interview, candidate: candidate, user: user
    end.to change { Interview.count }.by 1
    expect(@interview.user_id).to eq(user.id)
    expect(@interview.candidate_id).to eq(candidate.id)
    expect(@interview.status).to eq(Interview::PASS)
    expect(@interview.date_and_time.year).to eq(2015)
    expect(@interview.date_and_time.month).to eq(2)
    expect(@interview.date_and_time.day).to eq(1)
    expect(@interview.date_and_time.hour).to eq(11)
    expect(@interview.date_and_time.min).to eq(30)
  end
end
