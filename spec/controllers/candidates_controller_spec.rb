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
      expect {
        get :show, job_id: -1, id: -1
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
