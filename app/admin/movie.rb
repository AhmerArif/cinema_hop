ActiveAdmin.register Movie do

	controller do
	    def permitted_params
	      params.permit!
	    end

		def find_resource
			scoped_collection.friendly.find(params[:id])
		end
	end

 form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Details" do
    f.input :name
    f.input :language, :as => :select, :collection => ['English', 'Urdu', 'Punjabi', 'Other'], :include_blank => false
    f.input :imdb_link, :as => :url
    f.input :rotten_tomatoes_link, :as => :url
    f.input :poster, :as => :file, :hint => f.object.poster.options[:default_url]=="/images/:style/missing.png" ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.poster.url(:medium))
  end
  f.buttons
 end

  index do
    selectable_column
    column "Poster" do |movie|
      link_to(image_tag(movie.poster(:thumb)), admin_movie_path(movie))
    end
    column :name
    column :language
    column "IMDB" do |movie|
      link_to movie.imdb_link, movie.imdb_link.to_s
    end
    column "Rotten Tomatoes" do |movie|
      link_to movie.rotten_tomatoes_link, movie.rotten_tomatoes_link.to_s
    end
    column :created_at
    column :updated_at
    default_actions
  end


=begin

  index :as => :grid do |movie|
    
  end
=end

end