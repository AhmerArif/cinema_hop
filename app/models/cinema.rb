class Cinema < ActiveRecord::Base
	belongs_to :city
	has_many :movies, through: :showtimes 
	has_many :showtimes, dependent: :destroy

  	validates :website, presence: {message: "You missed the link"}, url: {message: "Do make sure you put in a proper URL like http://yourmom.com"} 
	validates :name, presence: {message: "A name for the cinema sure would be nice"}, uniqueness: {message: "Can't have a cinema with a duplicate name folks!"}
end
