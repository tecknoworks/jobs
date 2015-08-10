ActiveAdmin.register Job do
  permit_params :description, :status

  form do |f|
    columns do
      column do
        f.inputs :status
        f.inputs 'Admin Details' do
          f.input :description
        end

        f.actions
      end

      column do
        render 'markdown_editor'
      end
    end
  end
end
