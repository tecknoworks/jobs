json.(interview, :id, :candidate_id, :user_id, :status, :created_at, :updated_at)
json.date interview.date_and_time.strftime('%d/%m/%Y')
json.time interview.date_and_time.strftime('%R')
json.user_name User.find(interview[:user_id]).email
