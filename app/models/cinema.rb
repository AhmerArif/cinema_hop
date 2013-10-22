class Cinema < ActiveRecord::Base
	belongs_to :city
	has_many :movies, through: :showtimes 
	has_many :showtimes 

  	validates :website, :url => true
	validates :website, presence: true
	validates :name, presence: true
	validates :name, uniqueness: true
end
