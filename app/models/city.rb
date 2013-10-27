class City < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :cinemas, dependent: :destroy

	validates :name, presence: true, uniqueness: true

	def current_movies
		Movie.currently_showing(self)
	end

	def current_cinemas(movie)
		movie.cinemas.includes(:showtimes).where('showtimes.showing_at >= ? AND cinemas.id in (?)', Time.now-30.minutes, default_city? ? Cinema.all : cinemas).order('cinemas.name ASC').references(:showtimes)
	end

	def default_city?
		name=="All" || name.blank? ? true : false
	end

	def self.default_city
		City.find_by name: 'All'
	end



end