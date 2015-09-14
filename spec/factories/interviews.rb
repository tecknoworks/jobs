FactoryGirl.define do
  factory :interview do
    candidate
    user
    status Interview::PASS
    date_and_time '2015-2-1 11:30'
  end

  factory :interview_with_invalid_status, parent: :interview do
    status(-1)
  end
end
