require 'rails_helper'

describe TkwAuth do
  describe TkwAuthTestsController, type: :controller do
    before :each do
      # This route exists only in test environment
      @request.env['devise.mapping'] = Devise.mappings[:user]
      allow_any_instance_of(Ldap).to receive(:valid?).and_return(false)
    end

    let(:user) { create :user }

    it 'authenticates the user' do
      post :create, user: { email: user.email, password: user.password }
      expect(response).to have_http_status :found
    end

    it 'requies correct params' do
      post :create, user: { email: 'fake', password: 'fake' }
      expect(response).to have_http_status :ok
    end

    it 'creates the user on succesfull authentication' do
      allow_any_instance_of(Ldap).to receive(:valid?).and_return(true)
      expect {
        post :create, user: { email: 'valid@email.com', password: 'password' }
      }.to change { User.count }.by 1
    end

    it 'does not create the user on unsuccesfull authentication' do
      expect {
        post :create, user: { email: 'valid@email.com', password: 'password' }
      }.to change { User.count }.by 0
    end
  end
end
