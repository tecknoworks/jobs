require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  render_views

  before(:each) do
    @candidate1 = create :candidate
    @candidate2 = create :candidate
    @user1 = create :user, email: 'test@test.com'
    @user2 = create :user, email: 'admin@example.com'
    @job1 = create :job
    @job2 = create :job
  end

  describe 'GET index' do
    it 'works' do
      create :attachment, candidate_id: @candidate1.id, user: @user1
      create :attachment, candidate_id: @candidate1.id, user: @user2
      create :attachment, candidate_id: @candidate2.id, user: @user1

      get :index, candidate_id: @candidate1.id, job_id: @job1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, candidate_id: @candidate2.id, job_id: @job1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)

      get :index, candidate_id: 111, job_id: @job1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(0)
    end
  end

  describe 'GET show' do
    it 'works' do
      @attachment1 = create :attachment, candidate_id: @candidate1.id, user: @user1
      @attachment2 = create :attachment, candidate_id: @candidate2.id, user: @user2

      get :show, candidate_id: @candidate1.id, job_id: @job1.id, id: @attachment1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:candidate_id]).to eq(@candidate1.id)
    end
  end
end
