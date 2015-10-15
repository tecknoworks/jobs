FactoryGirl.define do
  factory :candidate do
    job
    full_name 'Full Name'
    phone_number '0755555555'
    email 'email@example.com'
    source 'tkw user'
  end
end
