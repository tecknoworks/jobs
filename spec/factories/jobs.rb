FactoryGirl.define do
  factory :job do
    description "Test\nfoo"
    status Job::PUBLISHED
  end
end
