ActiveAdmin.register Cinema do

controller do
    def permitted_params
      params.permit!
    end

    def scoped_collection
      resource_class.includes(:city) # prevents N+1 queries to your database
    end
end

  index do
  	column :name
  	column :city, sortable: 'cities.name'
    column "Website" do |cinema|
      link_to cinema.website, cinema.website.to_s
    end
    column :created_at
    column :updated_at
    default_actions
  end

end
