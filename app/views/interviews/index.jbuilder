json.code 200
json.body do |json|
  json.partial! 'interview', collection: @interviews, as: :interview
end
