FactoryGirl.define do
  factory :job_without_status, class: Job do
    description "Test\nfoo"
  end

  factory :job, parent: :job_without_status do
    status Job::PUBLISHED
  end
end
