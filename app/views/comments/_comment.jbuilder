json.(comment, :id, :user_id, :interview_id, :body)

email = User.find(comment.user_id).email
email = email.split('@')
email = email[0].split('.')
if email.count == 2
  json.user_name email[1].capitalize + ' ' + email[0].capitalize
else
  json.user_name email[0].capitalize
end
