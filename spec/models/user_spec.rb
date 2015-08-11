require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_presence_of :password }

  it 'create user' do
    expect do
      user
    end.to change { User.count }.by 1
  end

  it 'create user when account exist' do
    expect do
      user
    end.to change { User.count }.by 1

    expect do
      user
    end.to change { User.count }.by 0
  end
end
