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
end
