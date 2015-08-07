ActiveAdmin.register Job do
  permit_params :description

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  show do |f|
    h3 f.description

    # TODO: render markdown output
    render 'markdown_editor'
  end

  form do |f|
    columns do
      column do
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
