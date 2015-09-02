json.code 200
json.body do |json|
  json.partial! 'interview', interview: @interview
end
