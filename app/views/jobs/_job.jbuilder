json.(job, :id, :title, :description, :created_at, :updated_at)
json.posted_at job.created_at.strftime('%Y%m%d')
