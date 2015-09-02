require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  render_views

  before(:each) do
    @job1 = create :job
    @job2 = create :job
  end

  describe 'GET index' do
    it 'works' do
      create :candidate, job_id: @job1.id
      create :candidate, job_id: @job1.id
      create :candidate, job_id: @job2.id

      get :index, job_id: @job1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, job_id: @job2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)

      get :index, job_id: 111, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(0)
    end
  end

  describe 'GET show' do
    it 'works' do
      candidate1 = create :candidate, job_id: @job1.id
      candidate2 = create :candidate, job_id: @job2.id

      get :show, job_id: @job1.id, id: candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:job_id]).to eq(@job1.id)

      get :show, job_id: @job2.id, id: candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:job_id]).to eq(@job2.id)
    end

    it 'returns 404 if record not found' do
      expect do
        get :show, job_id: -1, id: -1
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'works' do
      expect do
        post :create, candidate: { full_name: 'ionut', phone_number: '0722222222', email: 'test@example.com' }, job_id: 1, format: :json
      end.to change { Candidate.count }.by 1
      expect(json[:code]).to eq(200)
      expect(json[:body][:phone_number]).to eq('0722222222')
      expect(json[:body][:full_name]).to eq('ionut')
      expect(json[:body][:email]).to eq('test@example.com')
      expect(json[:body][:job_id]).to eq(1)
    end

    it 'one argument not exist' do
      expect do
        post :create, candidate: { full_name: 'ionut', phone_number: '0722222222' }, job_id: 1, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
