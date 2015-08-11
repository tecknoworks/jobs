FactoryGirl.define do
  factory :attachment do
    user
    candidate
    status Attachment::PENDING
    file Rack::Test::UploadedFile.new('spec/erd.pdf')
  end
end
