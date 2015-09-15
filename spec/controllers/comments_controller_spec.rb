require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  render_views

  before(:each) do
    @user = create :user
    @key = create :key, user_id: @user.id
    @interview = create :interview, user_id: @user.id
    create :comment, interview_id: @interview.id, user_id: @user.id
    @comment = create :comment, interview_id: @interview.id, user_id: @user.id
  end

  let(:consumer_key) { return @key.consumer_key }
  let(:secret_key) { return @key.secret_key }
  let(:valid_comment) { return { body: 'text...', interview_id: @interview.id } }

  describe 'GET #index' do
    it 'returns http success' do
      get :index, consumer_key: consumer_key, secret_key: secret_key, format: :json
      expect(response).to have_http_status(:success)
    end

    it 'when user is logged' do
      get :index, consumer_key: consumer_key, secret_key: secret_key, interview_id: @interview.id, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body].count).to eq(2)
    end

    it 'when user is logged but interview is invalid' do
      get :index, consumer_key: consumer_key, secret_key: secret_key, interview_id: -1, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body]).to eq([])
    end

    it 'when user is not logged' do
      get :index, consumer_key: '', secret_key: '', format: :json
      expect(json['code']).to eq(400_001)
      expect(json['body']).to eq('You are not logged')
    end

    it 'return user_name from email' do
      @comment = create :comment, interview_id: @interview.id, user_id: @user.id

      get :index, consumer_key: consumer_key, secret_key: secret_key, interview_id: @interview.id, format: :json
      expect(json['code']).to eq(200)
      expect(json['body'][0]['user_name']).to eq('User')

      Comment.delete_all

      user = create :user, email: 'firstname.lastname@example.com'
      @comment = create :comment, interview_id: @interview.id, user_id: user.id

      get :index, consumer_key: consumer_key, secret_key: secret_key, interview_id: @interview.id, format: :json
      expect(json['code']).to eq(200)
      expect(json['body'][0]['user_name']).to eq('Lastname Firstname')
    end
  end

  describe 'GET #create' do
    it 'returns http success' do
      get :create, consumer_key: consumer_key, secret_key: secret_key, comment: valid_comment, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  it 'when user is logged' do
    get :create, consumer_key: consumer_key, secret_key: secret_key, comment: valid_comment, format: :json
    expect(json[:code]).to eq(200)
    expect(json[:body][:user_id]).to eq(@user.id)
    expect(json[:body][:interview_id]).to eq(@interview.id)
    expect(json[:body][:body]).to eq('text...')
  end

  it 'when user is not logged' do
    get :create, consumer_key: '', secret_key: '', comment: valid_comment, format: :json
    expect(json[:code]).to eq(400_001)
    expect(json[:body]).to eq('You are not logged')
  end

  it 'when interview_id not exist or body is nill' do
    expect do
      get :create, consumer_key: consumer_key, secret_key: secret_key, comment: { body: 'text...', interview_id: -1 }, format: :json
    end.to raise_error ActiveRecord::RecordInvalid

    expect do
      get :create, consumer_key: consumer_key, secret_key: secret_key, comment: { body: '', interview_id: @interview.id }, format: :json
    end.to raise_error ActiveRecord::RecordInvalid
  end
end
