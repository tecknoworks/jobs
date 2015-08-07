json.code 200
json.body do |json|
  json.partial! 'attachment', collection: @attachments, as: :attachment
end
