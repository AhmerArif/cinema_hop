ActiveAdmin.register City do

config.comments = false
  
  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    default_actions
  end

 controller do
    def permitted_params
      params.permit!
    end

    def find_resource
	  	scoped_collection.friendly.find(params[:id])
    end
  end

  form do |f|
      f.inputs "Details" do
        f.input :name
      end
      f.actions
    end
end