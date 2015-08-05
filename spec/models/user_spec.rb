require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_presence_of :password }

  it 'create user' do
    expect do
      User.create(email: 'test@example.ro', password: 'password')
    end.to change { User.count }.by 1
  end

  it 'create user when account exist' do
    expect do
      User.create(email: 'test@example.ro', password: 'password')
    end.to change { User.count }.by 1

    expect do
      User.create(email: 'test@example.ro', password: 'password')
    end.to change { User.count }.by 0
  end
end
