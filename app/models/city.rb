class City < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :cinemas

	validates :name, presence: true
	validates :name, uniqueness: true
end