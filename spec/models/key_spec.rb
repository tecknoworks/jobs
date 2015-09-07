require 'rails_helper'

RSpec.describe Key, type: :model do
  let(:key) { create :key }
  it { expect(subject).to belong_to :user }

  it 'work' do
    expect do
      key
    end.to change { Key.count }.by 1
  end

  it 'set keys' do
    key = create :key
    expect(key.consumer_key).to_not be_nil
    expect(key.secret_key).to_not be_nil
  end
end
