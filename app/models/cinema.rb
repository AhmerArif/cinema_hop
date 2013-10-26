class Cinema < ActiveRecord::Base
	belongs_to :city
	has_many :movies, through: :showtimes 
	has_many :showtimes, dependent: :destroy

  	validates :website, presence: true, url: {message: "Do make sure you put in a proper URL like http://yourmom.com"} 
	validates :name, presence: true, uniqueness: true
	validates :city, presence: true
end