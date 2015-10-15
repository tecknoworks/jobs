ActiveAdmin.register Candidate do
  permit_params :full_name, :phone_number, :email, :job_id, :source
end
