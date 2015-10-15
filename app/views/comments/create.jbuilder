json.code 200
json.body do |json|
  json.partial! 'comment', comment: @comment
end
