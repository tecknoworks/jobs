json.id attachment.id.to_s
json.call(attachment, :job_id)
json.call(attachment, :status)
json.call(attachment, :file)
json.created_at attachment.created_at
json.updated_at attachment.updated_at
