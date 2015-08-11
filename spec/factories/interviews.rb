FactoryGirl.define do
  factory :interview do
    candidate
    user
    status Interview::PASS
  end
end
