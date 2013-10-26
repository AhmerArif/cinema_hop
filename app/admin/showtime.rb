ActiveAdmin.register Showtime do
scope :current, :default => true
scope :old

config.sort_order = "showing_at_desc"

controller do
    def permitted_params
      params.permit!
    end
end

form do |f|
   f.inputs "Details" do
    f.input :cinema
    f.input :movie
    f.input :showing_at, :as => :just_datetime_picker
    f.input  :is_3d
    f.input  :adults_only
  end
  f.buttons
 end

  index do
  	selectable_column
  	column :cinema, sortable: 'cinemas.name'
  	column :movie, sortable: 'movies.name'
  	column "Start Time", :sortable => :showing_at do |showtime|
      showtime.humanize_showing_at
    end
    column :is_3d, :sortable => :is_3d do|showtime|
      showtime.is_3d? ? 'Yes' : 'No'
    end
    column :adults_only, :sortable => :adults_only do|showtime|
      showtime.adults_only? ? 'Yes' : 'No'
    end
    column :created_at
    column :updated_at
    default_actions
  end

    show :title => :name do |showtime|
      attributes_table do
        row :movie
        row :cinema
        row :showing_at do 
          showtime.humanize_showing_at
        end
        row :is_3d do 
          showtime.is_3d? ? 'Yes' : 'No'
        end
        row :adults_only do 
          showtime.adults_only? ? 'Yes' : 'No'
        end
        row :created_at
        row :updated_at
      end
    end

end