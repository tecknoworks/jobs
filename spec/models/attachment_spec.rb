require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { expect(subject).to belong_to :job }

  it { expect(subject).to validate_presence_of :job }
  it { expect(subject).to validate_presence_of :status }

  let(:attachment) { create :attachment }

  it 'works' do
    p attachment.file
  end
end
