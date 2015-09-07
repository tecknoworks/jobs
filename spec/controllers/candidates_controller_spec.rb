require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  render_views

  before(:each) do
    @job1 = create :job
    @job2 = create :job
  end

  describe 'GET index' do
    it 'when user is logged' do
      key = create :key
      create :candidate, job_id: @job1.id
      create :candidate, job_id: @job1.id
      create :candidate, job_id: @job2.id

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: @job1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: @job2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: 111, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(0)
    end

    it 'when user is not logged' do
      create :candidate, job_id: @job1.id

      get :index, consumer_key: '', secret_key: '', job_id: @job1.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end
  end

  describe 'GET show' do
    it 'when user is logged' do
      key = create :key
      candidate1 = create :candidate, job_id: @job1.id
      candidate2 = create :candidate, job_id: @job2.id

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: @job1.id, id: candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:job_id]).to eq(@job1.id)

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: @job2.id, id: candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:job_id]).to eq(@job2.id)
    end

    it 'when user is not logged' do
      candidate1 = create :candidate, job_id: @job1.id

      get :show, consumer_key: '', secret_key: '', job_id: @job1.id, id: candidate1.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'returns 404 if record not found' do
      key = create :key
      expect do
        get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: -1, id: -1
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'when user is logged' do
      key = create :key
      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, candidate: { full_name: 'ionut', phone_number: '0722222222', email: 'test@example.com' }, job_id: 1, format: :json
      end.to change { Candidate.count }.by 1
      expect(json[:code]).to eq(200)
      expect(json[:body][:phone_number]).to eq('0722222222')
      expect(json[:body][:full_name]).to eq('ionut')
      expect(json[:body][:email]).to eq('test@example.com')
      expect(json[:body][:job_id]).to eq(1)
    end

    it 'when user is not logged' do
      post :create, consumer_key: '', secret_key: '', candidate: { full_name: 'ionut', phone_number: '0722222222', email: 'test@example.com' }, job_id: 1, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'one argument not exist' do
      key = create :key
      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, candidate: { full_name: 'ionut', phone_number: '0722222222' }, job_id: 1, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'DELETE destroy' do
    it 'when user is logged' do
      key = create :key
      job = create :job
      candidate = create :candidate, job_id: job.id

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: job.id, id: candidate.id, format: :json
      end.to change { Candidate.count }.by(-1)
    end

    it 'when user is not logged' do
      job = create :job
      candidate = create :candidate, job_id: job.id

      delete :destroy, consumer_key: '', secret_key: '', job_id: job.id, id: candidate.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'job not exist' do
      candidate = create :candidate
      key = create :key

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: -2, id: candidate.id, format: :json
      end.to change { Candidate.count }.by(-1)
    end

    it 'candidate not exist' do
      key = create :key
      job = create :job

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: job.id, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'PATCH update' do
    it 'update a single field' do
      key = create :key
      job = create :job
      candidate = create :candidate, job_id: job.id

      patch :update, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: job.id, candidate: { full_name: 'cata' }, id: candidate.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:full_name]).to eq('cata')
      expect(json[:body][:phone_number]).to eq(candidate.phone_number)
      expect(json[:body][:email]).to eq(candidate.email)
      expect(json[:body][:job_id]).to eq(candidate.job_id)
    end

    it 'update a single field when user is not logged' do
      job = create :job
      candidate = create :candidate, job_id: job.id

      patch :update, consumer_key: '', secret_key: '', job_id: job.id, candidate: { full_name: 'cata' }, id: candidate.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'update all fields' do
      key = create :key
      job = create :job
      candidate = create :candidate, job_id: job.id

      patch :update, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: job.id, candidate: { full_name: 'cata', phone_number: '0777777777', email: 'test@test.com' }, id: candidate.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:full_name]).to eq('cata')
      expect(json[:body][:phone_number]).to eq('0777777777')
      expect(json[:body][:email]).to eq('test@test.com')
      expect(json[:body][:job_id]).to eq(candidate.job_id)
    end

    it 'job not exist' do
      key = create :key
      job = create :job
      candidate = create :candidate, job_id: job.id

      patch :update, consumer_key: key.consumer_key, secret_key: key.secret_key, job_id: -1, candidate: { full_name: 'cata', phone_number: '0777777777', email: 'test@test.com' }, id: candidate.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:full_name]).to eq('cata')
      expect(json[:body][:phone_number]).to eq('0777777777')
      expect(json[:body][:email]).to eq('test@test.com')
      expect(json[:body][:job_id]).to eq(candidate.job_id)
    end
  end
end
