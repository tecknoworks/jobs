ActiveAdmin.register Attachment do
  permit_params :user_id, :status, :file, :candidate_id

  form do |f|
    f.inputs 'Admin Details' do
      f.input :user
      f.input :candidate
      f.input :file,  as: :file
    end
    f.actions
  end
end
