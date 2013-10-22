class Cinema < ActiveRecord::Base
	belongs_to :city

  	validates :website, :url => true
	validates :website, presence: true
	validates :name, presence: true
	validates :name, uniqueness: true
end
