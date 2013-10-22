class Movie < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	validates :imdb_link, :url => true
	validates :rotten_tomatoes_link, :url => true
	validates :name, presence: true
	validates :name, uniqueness: true

	has_many :cinemas, through: :showtimes
	has_many :showtimes
end
