require 'rails_helper'

RSpec.describe JobclientController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'not exist jobs' do
      get :index, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body]).to eq([])
    end

    it 'returns only published jobs' do
      create :job, status: Job::DRAFT
      create :job, status: Job::EXPIRED
      get :index, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(0)

      job = create :job, status: Job::PUBLISHED, description: "Title \n and description"

      get :index, format: :json
      expect(json[:body].count).to eq(1)
      expect(json[:body][0][:description]).to eq(job.description)
      expect(json[:body][0][:title]).to eq('Title')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      job = create :job
      get :show, id: job.id
      expect(response).to have_http_status(:success)
    end
  end
end
