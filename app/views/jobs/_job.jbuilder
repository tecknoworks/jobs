json.id job.id.to_s
json.(job, :title)
json.(job, :description)
json.created_at job.created_at
json.updated_at job.updated_at
