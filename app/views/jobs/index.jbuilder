json.code 200
json.body do |json|
  json.partial! 'job', collection: @jobs, as: :job
end
