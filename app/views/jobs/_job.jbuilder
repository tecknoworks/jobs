json.(job, :id, :title, :description, :status, :created_at, :updated_at)

candidates = Candidate.where(job_id: job.id)

json.candidates_count candidates.count

candidates_without_interview = 0
candidates.each do |candidate|
  if Interview.where(candidate_id: candidate.id).count == 0
    candidates_without_interview += 1
  end
end
json.candidates_without_interview candidates_without_interview
