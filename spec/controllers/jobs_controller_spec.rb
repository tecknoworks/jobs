require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  render_views

  before(:each) do
    Job.delete_all
    create :job, status: 1
  end

  describe 'GET index' do
    it 'works' do
      get :index, format: :json
      expect(response).to have_http_status :ok
    end

    it 'get all jobs' do
      get :index, format: :json
      expect(json['code']).to eq(200)
      expect(json['body']).to_not be_empty

      create :job
      create :job, status: 2
      create :job, status: 0

      get :index, format: :json
      expect(json['code']).to eq(200)
      expect(json['body'].count).to eq(2)
    end
  end

  describe 'GET show' do
    it 'get by id' do
      job = create :job, description: 'test'
      job2 = create :job, description: 'description'
      job3 = create :job, description: "Ruby\n here is description for ruby...\n test"

      get :show, id: job.id, format: :json
      expect(json['code']).to eq(200)
      expect(json['body']['title']).to eq('test')

      get :show, id: job2.id, format: :json
      expect(json['code']).to eq(200)
      expect(json['body']['title']).to eq('description')
      expect(json['body']['description']).to eq('description')

      get :show, id: job3.id, format: :json
      expect(json['code']).to eq(200)
      expect(json['body']['title']).to eq('Ruby')
      expect(json['body']['description']).to eq("Ruby\n here is description for ruby...\n test")
    end


    it 'returns 404 if record not found' do
      expect {
        get :show, job_id: -1, id: -1
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
