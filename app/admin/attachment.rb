ActiveAdmin.register Attachment do
  permit_params :user_id, :status, :file, :candidate_id

  form do |f|
    f.inputs 'Admin Details' do
      f.input :user_id, :as => :select, :collection => User.all.map{|u| ["#{u.email}", u.id]}
      f.input :candidate
      f.input :file,  as: :file
    end
    f.actions
  end
end
