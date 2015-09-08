json.(attachment, :id, :user_id, :candidate_id, :file, :created_at, :updated_at)
json.user_name User.find(attachment[:user_id]).email
