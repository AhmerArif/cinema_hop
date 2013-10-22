class Movie < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	
	validates :name, presence: true
	validates :name, uniqueness: true

end
