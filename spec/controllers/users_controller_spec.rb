require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'PUT login' do
    xit 'when user exist' do
      user = create :user

      put :login, user: { email: user.email, password: user.password }, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(user.id)
      expect(json[:body][:consumer_key]).to_not be_nil
      expect(json[:body][:secret_key]).to_not be_nil
    end

    xit 'when user not exist' do
      expect do
        put :login, user: { email: 'email@test.com', password: 'password' }, format: :json
      end.to change { User.count }.by 1
    end
  end

  describe 'DELETE logout' do
    it 'work' do
      key = create :key

      expect do
        delete :logout, consumer_key: key.consumer_key, secret_key: key.secret_key, id: key.id, format: :json
      end.to change { Key.count }.by(-1)
    end

    it 'when id != key.id' do
      user1 = create :user, email: 'test@example.com'
      user2 = create :user, email: 'example@example.com'
      key1 = create :key, user: user1
      key2 = create :key, user: user2
      expect do
        delete :logout, consumer_key: key1.consumer_key, secret_key: key1.secret_key, id: key2.id, format: :json
      end.to_not change { Key.count }
    end

    it 'when id not exist' do
      key = create :key
      expect do
        delete :logout, consumer_key: key.consumer_key, secret_key: key.secret_key, id: -1, format: :json
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'when user is not logged' do
      key = create :key
      expect do
        delete :logout, consumer_key: '', secret_key: '', id: key.id, format: :json
      end.to_not change { User.count }
      expect(json[:code]).to eq(200)
      expect(json[:body]).to eq('')
    end
  end
end
