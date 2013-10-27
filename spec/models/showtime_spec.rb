require 'spec_helper'

describe Showtime do
	let(:city) { FactoryGirl.create(:city) }
 	let(:cinema) { FactoryGirl.create(:cinema, city:city) }
 	let(:movie) { FactoryGirl.create(:movie) }

	context "attributes" do
		it { should have_db_column(:showing_at).of_type(:datetime) }
		it { should have_db_column(:adults_only).of_type(:boolean) }
		it { should have_db_column(:is_3d).of_type(:boolean) }
	end

	context "associations" do
		it { should belong_to(:cinema)}
		it { should belong_to(:movie)}
	end

	context "validations" do
		it { should validate_presence_of(:movie) }
		it { should validate_presence_of(:cinema) }
		it { should validate_presence_of(:showing_at) }
		#it { should ensure_inclusion_of(:adults_only).in_array([true, false]) } Shoulda Matchers seem to be broken for booleans
		#it { should validate_presence_of(:is_3d) }
		it { should validate_uniqueness_of(:showing_at).scoped_to(:movie_id, :cinema_id) }

		it "cannot be have the same showtime for the same cinema + movie" do
			expect(FactoryGirl.create(:showtime, movie:movie, cinema:cinema).valid?).to be_true
			expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema).valid?).to be_false
		end

		it "cannot be showing in the past" do 
			expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now-2.hours).valid?).to be_false
			expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now.midnight+34.hours).valid?).to be_true
		end

		it "can show only during cinema business hours" do 
			Timecop.freeze(Time.now.midnight+27.hours) do
				expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now).valid?).to be_false
			end
		end
	end

	context "methods" do
		
		describe "#humanize_showing_at" do 
			it "returns a human readable time string" do
				showtime = FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now)
				expect(showtime.humanize_showing_at).to be_kind_of(String)
			end
		end

		describe "#name" do 
			it "returns the movie name, cinema name and showing_at in a string" do
				showtime = FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now)
				expect(showtime.name).to include(movie.name)
				expect(showtime.name).to include(cinema.name)
				expect(showtime.name).to include(showtime.humanize_showing_at)
			end
		end

		describe ".current" do 
			it "returns showtimes that are less than 30 minutes old" do
				showtime = FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now)
				expect(Showtime.current).to include(showtime)
			end

			it "doesn't return showtimes that are more than 30 minutes old" do
				FactoryGirl.create(:showtime, movie:movie, cinema:cinema)
				Timecop.freeze(3.days.from_now) do
					expect(Showtime.current).to be_empty
				end
			end
		end	

		describe ".old" do 
			it "returns showtimes that are more than 30 minutes old" do
				showtime = FactoryGirl.create(:showtime, movie:movie, cinema:cinema)
				Timecop.freeze(showtime.showing_at+31.minutes) do
					expect(Showtime.old).to include(showtime)
				end
			end

			it "doesn't return showtimes that are less than 30 minutes old" do
				FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now)
				expect(Showtime.old).to be_empty
			end
		end	

	end


end