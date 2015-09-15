FactoryGirl.define do
  factory :comment do
    body 'Comment...'
    user_id user
    interview_id interview
  end
end
