FactoryGirl.define do
  factory :attachment do
    user
    candidate
    file Rack::Test::UploadedFile.new('spec/erd.pdf')
  end
end
