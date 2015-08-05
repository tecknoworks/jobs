require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  render_views

  before(:each) do
    @job1 = create :job
    @job2 = create :job

    @attachment1 = create :attachment, job_id: @job1.id
    @attachment2 = create :attachment, job_id: @job2.id
  end

  describe 'GET' do
    it 'index' do
      get :index, format: :json

      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)
    end

    it 'show' do
      get :show, id: @attachment1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:job_id]).to eq(@job1.id)
    end
  end
end
