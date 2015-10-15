require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create :comment }

  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :interview }

  it { expect(subject).to validate_presence_of :body }
  it { expect(subject).to validate_presence_of :interview }
  it { expect(subject).to validate_presence_of :user }

  it 'works' do
    user = create :user
    interview = create :interview, user_id: user.id
    expect(create :comment, user_id: user.id, interview_id: interview.id).to be_valid
  end

  it 'create comment' do
    user = create :user
    interview = create :interview, user_id: user.id
    expect do
      @comment = create :comment, user_id: user.id, interview_id: interview.id, body: 'test'
    end.to change { Comment.count }.by 1
    expect(@comment.user_id).to eq(user.id)
    expect(@comment.interview_id).to eq(interview.id)
    expect(@comment.body).to eq('test')
  end
end
