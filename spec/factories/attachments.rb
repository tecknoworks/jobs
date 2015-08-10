FactoryGirl.define do
  # TODO: code review
  factory :attachment do
    job
    status 1
    file Rack::Test::UploadedFile.new('spec/erd.pdf')
  end
end
