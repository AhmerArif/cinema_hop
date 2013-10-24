ActiveAdmin.register Showtime do

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
  end
  f.buttons
 end

  index do
  	selectable_column
  	column :cinema, sortable: 'cinemas.name'
  	column :movie, sortable: 'movies.name'
  	column "Start Time", :sortable => :showing_at do |showtime|
      showtime.showing_at.strftime("%A, %B #{showtime.showing_at.day.ordinalize} %Y at %I:%M %p")
    end
  	column :showing_at
    column :created_at
    column :updated_at
    default_actions
  end

end
