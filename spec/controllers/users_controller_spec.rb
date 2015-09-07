require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'PUT login' do
    it 'work' do
      user = create :user
      expect do
        put :login, email: user.email, password: user.password, format: :json
      end.to change { Key.count }.by 1
    end

    it 'when user exist' do
      user = create :user
      put :login, email: user.email, password: user.password, format: :json
      expect(json[:code]).to eq(200)
      expect(json[:body][:id]).to eq(user.id)
      expect(json[:body][:consumer_key]).to_not be_nil
      expect(json[:body][:secret_key]).to_not be_nil
    end

    it 'when user not exist' do
      put :login, email: 'test', password: 'test', format: :json
      expect(json[:code]).to eq(400_000)
      expect(json[:body]).to eq('User not exist')
    end
  end
end
