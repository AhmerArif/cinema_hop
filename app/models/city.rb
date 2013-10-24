class City < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :cinemas, dependent: :destroy

	validates :name, presence: true, uniqueness: true
end