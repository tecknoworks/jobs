json.(interview, :id, :candidate_id, :user_id, :status, :created_at, :updated_at)
json.user_name User.find(interview[:user_id]).email
