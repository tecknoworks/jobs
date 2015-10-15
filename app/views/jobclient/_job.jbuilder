json.(job, :id, :title, :description)
json.posted_at job.created_at.strftime('%Y%m%d')
