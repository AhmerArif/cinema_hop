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

end
