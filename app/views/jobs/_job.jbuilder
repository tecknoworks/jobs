json.(job, :id, :title, :description, :created_at, :updated_at)
json.posted_at job.created_at.strftime("%d %h %Y %I:%M")
