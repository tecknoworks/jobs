json.(job, :id, :title, :description, :status, :created_at, :updated_at)
json.posted_at job.created_at.strftime('%Y%m%d')
