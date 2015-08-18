FactoryGirl.define do
  factory :job_without_status, class: Job do
    description "Test\nfoo"
  end

  factory :job, parent: :job_without_status do
    status Job::PUBLISHED
  end

  factory :job_with_invalid_status, parent: :job_without_status do
    status(-1)
  end
end
