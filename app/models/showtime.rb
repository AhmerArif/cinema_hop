class Showtime < ActiveRecord::Base
  belongs_to :movie
  belongs_to :cinema
  just_define_datetime_picker :showing_at
end
