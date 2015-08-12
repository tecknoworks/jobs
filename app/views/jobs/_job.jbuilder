json.(job, :id, :title, :description, :created_at, :updated_at)
json.posted_at job.created_at.day.to_s + '/' + job.created_at.month.to_s + '/' + job.created_at.year.to_s + ' ' + job.created_at.hour.to_s + ':' + job.created_at.min.to_s
