json.code 200
json.body do |json|
  json.partial! 'candidate', candidate: @candidate
end
