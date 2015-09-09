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

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, candidate_id: -1, format: :json
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

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, candidate_id: candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, candidate_id: candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)
    end

    it 'when candidate exist and user are not logged' do
      candidate1 = create :candidate
      candidate2 = create :candidate
      user = create :user
      create :interview, candidate_id: candidate1.id, user_id: user.id

      get :index, consumer_key: '', secret_key: '', format: :json
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

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: interview.id, format: :json
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

      get :show, consumer_key: '', secret_key: '', id: interview.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when candidate not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: interview.id, format: :json
      expect(json[:code]).to eq(200)
    end

    it 'when interview not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      expect do
        get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'when user is logged' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: candidate.id, status: 1 }, format: :json
      end.to change { Interview.count }.by 1
      expect(json[:code]).to eq(200)
      expect(json[:body][:user_id]).to eq(user.id)
      expect(json[:body][:status]).to eq(1)
      expect(json[:body][:candidate_id]).to eq(candidate.id)
    end

    it 'when user is not logged' do
      candidate = create :candidate
      user = create :user

      post :create, consumer_key: '', secret_key: '', interview: { candidate_id: candidate.id, status: 1 }, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when exist interview and the user is the same' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: candidate.id, status: 1 }, format: :json
      end.to change { Interview.count }.by 1
      @interview = json[:body]
      expect(json[:code]).to eq(200)
      expect(json[:body][:user_id]).to eq(user.id)
      expect(json[:body][:status]).to eq(1)
      expect(json[:body][:candidate_id]).to eq(candidate.id)

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: candidate.id, status: 0 }, format: :json
      end.to change { Interview.count }.by 0
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(@interview['id'])
      expect(json[:body][:user_id]).to eq(@interview['user_id'])
      expect(json[:body][:status]).to_not eq(@interview['status'])
      expect(json[:body][:candidate_id]).to eq(@interview['candidate_id'])
    end

    it 'when exist interview, the user is the same but is another key' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      key2 = create :key, user_id: user.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: candidate.id, status: 1 }, format: :json
      end.to change { Interview.count }.by 1
      @interview = json[:body]
      expect(json[:code]).to eq(200)
      expect(json[:body][:user_id]).to eq(user.id)
      expect(json[:body][:status]).to eq(1)
      expect(json[:body][:candidate_id]).to eq(candidate.id)

      expect do
        post :create, consumer_key: key2.consumer_key, secret_key: key2.secret_key, interview: { candidate_id: candidate.id, status: 0 }, format: :json
      end.to change { Interview.count }.by 0
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(@interview['id'])
      expect(json[:body][:user_id]).to eq(@interview['user_id'])
      expect(json[:body][:status]).to_not eq(@interview['status'])
      expect(json[:body][:candidate_id]).to eq(@interview['candidate_id'])
    end

    it 'when exist interview and the user is not the same' do
      candidate = create :candidate
      user = create :user
      user2 = create :user, email: 'ionut@example.com'
      key = create :key, user_id: user.id
      key2 = create :key, user_id: user2.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: candidate.id, status: 1 }, format: :json
      end.to change { Interview.count }.by 1
      @interview = json[:body]
      expect(json[:code]).to eq(200)
      expect(json[:body][:user_id]).to eq(user.id)
      expect(json[:body][:status]).to eq(1)
      expect(json[:body][:candidate_id]).to eq(candidate.id)

      expect do
        post :create, consumer_key: key2.consumer_key, secret_key: key2.secret_key, interview: { candidate_id: candidate.id, status: 0 }, format: :json
      end.to change { Interview.count }.by 1
      expect(json[:code]).to eq(200)
      expect(json[:body][:user_id]).to eq(user2.id)
      expect(json[:body][:status]).to eq(0)
      expect(json[:body][:candidate_id]).to eq(candidate.id)
    end

    it 'when status/user_id/candidate_id is invalid' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: -1, status: 1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, interview: { candidate_id: -1, status: -1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid

      post :create, consumer_key: '', secret_key: '', interview: { candidate_id: -1, status: 1 }, format: :json
      expect(json[:code]).to eq(400_001)
    end
  end

  describe 'DELETE destroy' do
    it 'when user is logged' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, id: interview.id, format: :json
      end.to change { Interview.count }.by (-1)
    end

    it 'when user is not logged' do
      candidate = create :candidate
      user = create :user
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      delete :destroy, consumer_key: '', secret_key: '', id: interview.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when another user has created the interview' do
      candidate = create :candidate
      user = create :user
      interview = create :interview, candidate_id: candidate.id, user_id: user.id
      user2 = create :user, email: 'admin@example.com'
      key = create :key, user_id: user2.id

      delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, id: interview.id, format: :json
      expect(json[:code]).to eq(400_002)
      expect(json[:body]).to eq('Permission denied')
    end

    it 'when interview not exist' do
      candidate = create :candidate
      user = create :user
      key = create :key, user_id: user.id
      interview = create :interview, candidate_id: candidate.id, user_id: user.id

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
