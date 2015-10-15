json.code 200
json.body do |json|
  json.partial! 'key', key: @key
end
