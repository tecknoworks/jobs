require 'rails_helper'

RSpec.describe InterviewsController, type: :controller do
  render_views

  describe 'GET index' do
    it 'when candidate not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id

      create :interview, candidate_id: candidate.id, user_id: user.id
      create :interview, candidate_id: candidate.id, user_id: user.id
      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: -1, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body]).to eq([])
    end

    it 'when candidate exist' do
      candidate1 = create :candidate
      candidate2 = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      create :interview, candidate_id: candidate1.id, user_id: user.id
      create :interview, candidate_id: candidate1.id, user_id: user.id
      create :interview, candidate_id: candidate2.id, user_id: user.id

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)
    end

    it 'when candidate exist and user are not logged' do
      candidate1 = create :candidate
      candidate2 = create :candidate
      user = create :user
      create :interview, candidate_id: candidate1.id, user_id: user.id

      get :index, consumer_key: '', secret_key: '', job_id: 1, candidate_id: candidate1.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end
  end

  describe 'GET show' do
    it 'when user are logged' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate.id, id: interview.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(1)
      expect(json[:body][:candidate_id]).to eq(1)
      expect(json[:body][:user_id]).to eq(1)
      expect(json[:body][:status]).to eq(1)
    end

    it 'when user are not logged' do
      candidate = create :candidate
      user = create :user
      interview = create :interview, candidate_id: candidate.id, user_id: user.id
      get :show, consumer_key: '', secret_key: '', job_id: 1, candidate_id: candidate.id, id: interview.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when candidate not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: -1, id: interview.id, format: :json
      expect(json[:code]).to eq(200)
    end

    it 'when interview not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      expect do
        get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: -1, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'when user is logged' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate.id, interview: { user_id: user.id, status: 1 }, format: :json
      end.to change { Interview.count }.by 1
      expect(json[:code]).to eq(200)
      expect(json[:body][:user_id]).to eq(user.id)
      expect(json[:body][:status]).to eq(1)
      expect(json[:body][:candidate_id]).to eq(candidate.id)
    end

    it 'when user is not logged' do
      candidate = create :candidate
      user = create :user

      post :create, consumer_key: '', secret_key: '', job_id: 1, candidate_id: candidate.id, interview: { user_id: user.id, status: 1 }, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when status/user_id/candidate_id is invalid' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: -1, interview: { user_id: user.id, status: 1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate.id, interview: { user_id: user.id, status: -1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate.id, interview: { user_id: -1, status: 1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'DELETE destroy' do
    it 'when user is logged' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate.id, id: interview.id, format: :json
      end.to change { Interview.count }.by (-1)
    end

    it 'when user is not logged' do
      candidate = create :candidate
      user = create :user
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      delete :destroy, consumer_key: '', secret_key: '', job_id: 1, candidate_id: candidate.id, id: interview.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when interview not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 1, candidate_id: candidate.id, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
