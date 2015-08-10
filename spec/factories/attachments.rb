FactoryGirl.define do
  # TODO: code review
  factory :attachment do
    job
    status Attachment::PENDING
    file Rack::Test::UploadedFile.new('spec/erd.pdf')
  end
end
