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

      get :index, candidate_id: @candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, candidate_id: @candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)

      get :index, candidate_id: -1, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(0)
    end
  end

  describe 'GET show' do
    it 'works' do
      @attachment1 = create :attachment, candidate_id: @candidate1.id, user: @user1
      @attachment2 = create :attachment, candidate_id: @candidate2.id, user: @user2

      get :show, candidate_id: @candidate1.id, id: @attachment1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:candidate_id]).to eq(@candidate1.id)
    end

    it 'when candidate not exist' do
      expect do
        get :show, candidate_id: @candidate1.id, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'POST create' do
    it 'works' do
      expect do
        post :create, candidate_id: @candidate1.id, user_id: @user1.id, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), format: :json
      end.to change { Attachment.count }.by(1)
    end

    it 'when user not exist' do
      expect do
        post :create, candidate_id: @candidate1.id, user_id: -1, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'when candidate not exist' do
      expect do
        post :create, candidate_id: -1, user_id: @user1.id, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'when attachment not exist' do
      expect do
        post :create, candidate_id: @candidate1.id, user_id: @user1.id, attachment: '', format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'PATCH update' do
    it 'works' do
      @attachment = create :attachment, candidate_id: @candidate1.id, user: @user1
      patch :update, candidate_id: @candidate2.id, user_id: @user2.id, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), id: @attachment.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(@attachment.id)
      expect(json[:body][:candidate_id]).to eq(@candidate2.id)
      expect(json[:body][:user_id]).to eq(@user2.id)
    end

    it 'when user not exist' do
      @attachment = create :attachment, candidate_id: @candidate1.id, user: @user1
      expect do
        patch :update, candidate_id: @candidate1.id, user_id: -1, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), id: @attachment.id, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'when attachment not exist' do
      expect do
        patch :update, candidate_id: @candidate1.id, user_id: -1, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'DELETE destroy' do
    it 'works' do
      @attachment = create :attachment, candidate_id: @candidate1.id, user: @user1
      expect do
        delete :destroy, candidate_id: @candidate1.id, user_id: @user1.id, attachment: Rack::Test::UploadedFile.new('spec/erd.pdf'), id: @attachment.id, format: :json
      end.to change { Attachment.count }.by (-1)
    end

    it 'when attachment not exist' do
      expect do
        delete :destroy, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
