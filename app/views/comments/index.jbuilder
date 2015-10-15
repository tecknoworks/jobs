json.code 200
json.body do |json|
  json.partial! 'comment', collection: @comments, as: :comment
end
