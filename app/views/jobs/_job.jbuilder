json.(job, :id, :title, :description, :status, :created_at, :updated_at)
json.candidates_count Candidate.where(job_id: job.id).count 
json.posted_at job.created_at.strftime('%Y%m%d')
