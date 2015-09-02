require 'rails_helper'

RSpec.describe InterviewsController, type: :controller do
  render_views

  describe 'GET index' do
    it 'when candidate not exist' do
      candidate = create :candidate
      user = create :user
      create :interview, candidate_id: candidate.id, user_id: user.id
      create :interview, candidate_id: candidate.id, user_id: user.id
      get :index, job_id: 1, candidate_id: -1, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body]).to eq([])
    end

    it 'when candidate exist' do
      candidate1 = create :candidate
      candidate2 = create :candidate
      user = create :user
      interview1 = create :interview, candidate_id: candidate1.id, user_id: user.id
      interview1 = create :interview, candidate_id: candidate1.id, user_id: user.id
      interview1 = create :interview, candidate_id: candidate2.id, user_id: user.id
      get :index, job_id: 1, candidate_id: candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)
      get :index, job_id: 1, candidate_id: candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)
    end
  end
end
