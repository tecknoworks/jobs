ActiveAdmin.register Interview do
  permit_params :candidate_id, :status, :user_id
end
