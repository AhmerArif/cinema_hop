class Showtime < ActiveRecord::Base
	belongs_to :movie
	belongs_to :cinema
	
	scope :current, lambda {where("showing_at >= ?", Time.now-30.minutes).order('showing_at ASC')}
	scope :recent, :limit => 10, :order => 'created_at DESC'
	scope :old, lambda {where("showing_at <= ?", Time.now+30.minutes).order('showing_at ASC')}

	just_define_datetime_picker :showing_at

	validates :movie, presence: true
	validates :cinema, presence: true
	validates :showing_at, presence: true
	validates :adults_only, inclusion: [true, false]
	validates :is_3d, inclusion: [true, false]
	validates :showing_at, :uniqueness =>{:scope => [:movie_id, :cinema_id]}
	validates_datetime :showing_at
	validates_datetime :showing_at, :on_or_after => 30.minutes.ago, :on_or_after_message => "This showtime is old news man!"

	validate :showing_at_is_during_business_hours

	def showing_at_is_during_business_hours
		errors.add(:showing_at, 'must be during business hours') if (showing_at.midnight+3.hours..showing_at.midnight+8.hours).cover?(showing_at) unless showing_at.nil?
	end

	def humanize_showing_at
		showing_at.strftime("%A, %B #{showing_at.day.ordinalize} %Y at %I:%M %p")
	end

	def name
		"#{movie.name} @ #{cinema.name} @ #{humanize_showing_at}"
	end

end