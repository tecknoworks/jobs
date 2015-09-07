require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  render_views

  before(:each) do
    Job.delete_all
    create :job, status: 1
  end

  describe 'GET index' do
    it 'when the user is logged' do
      key = create :key
      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, format: :json
      expect(response).to have_http_status :ok
    end

    it 'when the user is not logged' do
      get :index, consumer_key: '', secret_key: 'asd', format: :json
      expect(response).to have_http_status 400_001
    end

    it 'get all jobs' do
      key = create :key
      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body]).to_not be_empty

      create :job
      create :job, status: 2
      create :job, status: 0

      get :index, consumer_key: key.consumer_key, secret_key: key.secret_key, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(4)
    end
  end

  describe 'GET show' do
    it 'get by id when user is logged' do
      key = create :key

      job = create :job, description: 'test'
      job2 = create :job, description: 'description'
      job3 = create :job, description: "Ruby\n here is description for ruby...\n test"

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:title]).to eq('test')
      expect(json[:body][:status]).to eq(job.status)

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:title]).to eq('description')
      expect(json[:body][:description]).to eq('description')

      get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job3.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:title]).to eq('Ruby')
      expect(json[:body][:description]).to eq("Ruby\n here is description for ruby...\n test")
    end

    it 'get by id when user is not logged' do
      job = create :job, description: 'test'

      get :show, consumer_key: '', secret_key: '', id: job.id, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'returns 404 if record not found' do
      key = create :key
      expect do
        get :show, consumer_key: key.consumer_key, secret_key: key.secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'when user is logged' do
      key = create :key

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job: { description: 'test...', status: 1 }, format: :json
      end.to change { Job.count }.by 1
    end

    it 'when user is not logged' do
      post :create, consumer_key: '', secret_key: '', job: { description: 'test...', status: 1 }, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'description is nil' do
      key = create :key

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job: { description: '', status: 1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'status not exist' do
      key = create :key

      expect do
        post :create, consumer_key: key.consumer_key, secret_key: key.secret_key, job: { description: 'test...', status: -1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'DELETE destroy' do
    it 'when user is logged' do
      key = create :key
      create :job
      job = create :job

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job.id, format: :json
      end.to change { Job.count }.by(-1)
    end

    it 'when user is not logged' do
      create :job
      job = create :job

      delete :destroy, consumer_key: '', secret_key: '', id: job.id, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'job not exist' do
      key = create :key

      expect do
        delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'PATCH update' do
    it 'when user is logged' do
      key = create :key
      job = create :job

      patch :update, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job.id, job: { description: 'desc', status: 2 }, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(job.id)
      expect(json[:body][:description]).to eq('desc')
      expect(json[:body][:status]).to eq(2)
    end

    it 'when user is not logged' do
      job = create :job

      patch :update, consumer_key: '', secret_key: '', id: job.id, job: { description: 'desc', status: 2 }, format: :json
      expect(json[:code]).to eq(400_001)
    end

    it 'desciption is nil' do
      key = create :key
      job = create :job
      expect do
        patch :update, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job.id, job: { description: '', status: 2 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'status not exist' do
      key = create :key
      job = create :job
      expect do
        patch :update, consumer_key: key.consumer_key, secret_key: key.secret_key, id: job.id, job: { description: 'desc', status: -1 }, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
