FactoryGirl.define do
  factory :interview do
    candidate
    user
    status Interview::PASS
  end

  factory :interview_with_invalid_status, parent: :interview do
    status(-1)
  end
end
