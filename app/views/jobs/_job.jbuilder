# CODE: similar to _attachment.jbuilder
json.id job.id.to_s
json.call(job, :title)
json.call(job, :description)
json.created_at job.created_at
json.updated_at job.updated_at
