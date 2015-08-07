json.code 200
json.body do |json|
  json.partial! 'job', job: @job
end
