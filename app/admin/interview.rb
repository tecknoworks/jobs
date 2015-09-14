ActiveAdmin.register Interview do
  permit_params :candidate_id, :user_id, :date_and_time

  index do
    selectable_column
    column :candidate
    column :user
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Interview' do
      f.input :candidate
      f.input :user
      f.input :date_and_time
    end
    f.actions
  end
end
