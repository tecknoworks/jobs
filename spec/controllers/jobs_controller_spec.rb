require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  render_views

  before(:each) do
    Job.delete_all
    @key = create :key
    @job = create :job, status: 1
  end

  let(:valid_job) { return { description: 'description', status: Job::PUBLISHED } }
  let(:invalid_description_job) { return { description: '', status: Job::PUBLISHED } }
  let(:invalid_status_job) { return { description: 'description', status: -1 } }
  let(:consumer_key) { return @key.consumer_key }
  let(:secret_key) { return @key.secret_key }

  describe 'GET index' do
    it 'when the user is logged' do
      get :index, consumer_key: consumer_key, secret_key: secret_key, format: :json
      expect(response).to have_http_status :ok
    end

    it 'when the user is not logged' do
      get :index, consumer_key: '', secret_key: '', format: :json
      expect(response).to have_http_status 400_001
    end

    it 'get all jobs' do
      get :index, consumer_key: consumer_key, secret_key: secret_key, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body]).to_not be_empty

      create :job
      create :job, status: Job::FILLED
      create :job, status: Job::DRAFT

      get :index, consumer_key: consumer_key, secret_key: secret_key, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(4)
    end
  end

  describe 'GET show' do
    it 'get by id when user is logged' do
      job = create :job, description: 'test'
      job2 = create :job, description: 'description'
      job3 = create :job, description: "Ruby\n here is description for ruby...\n test"

      get :show, consumer_key: consumer_key, secret_key: secret_key, id: job.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:title]).to eq('test')
      expect(json[:body][:status]).to eq(job.status)

      get :show, consumer_key: consumer_key, secret_key: secret_key, id: job2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:title]).to eq('description')
      expect(json[:body][:description]).to eq('description')

      get :show, consumer_key: consumer_key, secret_key: secret_key, id: job3.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:title]).to eq('Ruby')
      expect(json[:body][:description]).to eq("Ruby\n here is description for ruby...\n test")
    end

    it 'get by id when user is not logged' do
      get :show, consumer_key: '', secret_key: '', id: @job.id, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'returns 404 if record not found' do
      expect do
        get :show, consumer_key: consumer_key, secret_key: secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'when user is logged' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, job: valid_job, format: :json
      end.to change { Job.count }.by 1
    end

    it 'when user is not logged' do
      post :create, consumer_key: '', secret_key: '', job: valid_job, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'description is nil' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, job: invalid_description_job, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'status not exist' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, job: invalid_status_job, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'DELETE destroy' do
    it 'when user is logged' do
      expect do
        delete :destroy, consumer_key: consumer_key, secret_key: secret_key, id: @job.id, format: :json
      end.to change { Job.count }.by(-1)
    end

    it 'when user is not logged' do
      delete :destroy, consumer_key: '', secret_key: '', id: @job.id, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'job not exist' do
      expect do
        delete :destroy, consumer_key: consumer_key, secret_key: secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'PATCH update' do
    it 'when user is logged' do
      patch :update, consumer_key: consumer_key, secret_key: secret_key, id: @job.id, job: valid_job, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(@job.id)
      expect(json[:body][:description]).to eq('description')
      expect(json[:body][:status]).to eq(1)
    end

    it 'when user is not logged' do
      patch :update, consumer_key: '', secret_key: '', id: @job.id, job: valid_job, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'desciption is nil' do
      expect do
        patch :update, consumer_key: consumer_key, secret_key: secret_key, id: @job.id, job: invalid_description_job, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'status not exist' do
      expect do
        patch :update, consumer_key: consumer_key, secret_key: secret_key, id: @job.id, job: invalid_status_job, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
