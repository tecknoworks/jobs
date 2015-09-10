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
    @key = create :key, user_id: @user1.id
  end

  let(:consumer_key) { return @key.consumer_key }
  let(:secret_key) { return @key.secret_key }
  let(:valid_attachment) { return { candidate_id: @candidate1.id, user_id: @user1.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf') } }
  let(:invalid_user_attachment) { return { candidate_id: @candidate1.id, user_id: -1, file: Rack::Test::UploadedFile.new('spec/erd.pdf') } }
  let(:invalid_candidate_attachment) { return { candidate_id: -1, user_id: @user1.id, file: Rack::Test::UploadedFile.new('spec/erd.pdf') } }
  let(:invalid_file_attachment) { return { candidate_id: @candidate1.id, user_id: @user1.id, file: '' } }

  describe 'GET index' do
    it 'works when user is logged' do
      create :attachment, candidate_id: @candidate1.id, user: @user1
      create :attachment, candidate_id: @candidate1.id, user: @user2
      create :attachment, candidate_id: @candidate2.id, user: @user1

      get :index, consumer_key: consumer_key, secret_key: secret_key, candidate_id: @candidate1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)

      get :index, consumer_key: consumer_key, secret_key: secret_key, candidate_id: @candidate2.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(1)

      get :index, consumer_key: consumer_key, secret_key: secret_key, candidate_id: -1, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(0)
    end

    it 'when user is not logged' do
      create :attachment, candidate_id: @candidate1.id, user: @user1
      create :attachment, candidate_id: @candidate1.id, user: @user2
      create :attachment, candidate_id: @candidate2.id, user: @user1

      get :index, consumer_key: '', secret_key: '', candidate_id: @candidate1.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')

      get :index, consumer_key: '', secret_key: '', candidate_id: @candidate2.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end
  end

  describe 'GET show' do
    it 'works when user is logged' do
      attachment1 = create :attachment, candidate_id: @candidate1.id, user: @user1
      create :attachment, candidate_id: @candidate2.id, user: @user2

      get :show, consumer_key: consumer_key, secret_key: secret_key, id: attachment1.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:candidate_id]).to eq(@candidate1.id)
    end

    it 'when user is not logged' do
      attachment = create :attachment, candidate_id: @candidate1.id, user: @user1

      get :show, consumer_key: '', secret_key: '', id: attachment.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end
  end

  describe 'POST create' do
    it 'works when user is logged' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, attachment: valid_attachment, format: :json
      end.to change { Attachment.count }.by(1)
    end

    it 'when user is not logged' do
      post :create, consumer_key: '', secret_key: '', attachment: valid_attachment, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when user not exist' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, attachment: invalid_user_attachment, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'when candidate not exist' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, attachment: invalid_candidate_attachment, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'when attachment not exist' do
      expect do
        post :create, consumer_key: consumer_key, secret_key: secret_key, attachment: invalid_file_attachment, format: :json
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'DELETE destroy' do
    it 'works when user is logged' do
      attachment = create :attachment, candidate_id: @candidate1.id, user: @user1

      expect do
        delete :destroy, consumer_key: consumer_key, secret_key: secret_key, id: attachment.id, format: :json
      end.to change { Attachment.count }.by(-1)
    end

    it 'when another user created attachment' do
      key = create :key, user_id: @user2.id
      attachment = create :attachment, candidate_id: @candidate1.id, user: @user1

      delete :destroy, consumer_key: key.consumer_key, secret_key: key.secret_key, id: attachment.id, format: :json
      expect(json[:code]).to eq(400_002)
      expect(json[:body]).to eq('Permission denied')
    end

    it 'when user is not logged' do
      attachment = create :attachment, candidate_id: @candidate1.id, user: @user1

      delete :destroy, consumer_key: '', secret_key: '', id: attachment.id, format: :json
      expect(json[:code]).to eq(400_001)
      expect(json[:body]).to eq('You are not logged')
    end

    it 'when attachment not exist' do
      expect do
        delete :destroy, consumer_key: consumer_key, secret_key: secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
