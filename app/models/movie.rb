class Movie < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	validates :imdb_link, :url => {message: "Messed up the URL there buddy"}
	validates :rotten_tomatoes_link, :url => {message: "Moar like a rotten link amirite?"}
	validates :name, presence: {message:"Wake up! Movies need names"}, uniqueness: {message:"There's a movie with this name already"}

	has_many :cinemas, through: :showtimes
	has_many :showtimes, dependent: :destroy

	has_attached_file :poster, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

end
