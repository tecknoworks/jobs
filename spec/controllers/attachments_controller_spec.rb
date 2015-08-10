require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  render_views

  before(:each) do
    @job1 = create :job
    @job2 = create :job
  end

  # CODE: no skipz plz
  xdescribe 'GET' do
    it 'index' do
      create :attachment, job_id: @job1.id
      create :attachment, job_id: @job1.id
      create :attachment, job_id: @job2.id

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

    it 'show' do
      @attachment1 = create :attachment, job_id: @job1.id
      @attachment2 = create :attachment, job_id: @job2.id

      get :show, job_id: @job1.id, id: @attachment1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:job_id]).to eq(@job1.id)
    end
  end
end
