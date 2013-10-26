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

		it "cannot be created with the same showtime for the same cinema + movie" do
			Timecop.freeze(Time.now.midnight + 42.hours) do
				expect(FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now).valid?).to be_true
				expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now).valid?).to be_false
			end
		end

		it "cannot be created in the past" do 
			expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now-1.hours).valid?).to be_false
			expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now.midnight+34.hours).valid?).to be_true
		end

		it "can only fall between cinema business hours" do 
			Timecop.freeze(Time.now.midnight+27.hours) do
				expect(FactoryGirl.build(:showtime, movie:movie, cinema:cinema, showing_at: Time.now).valid?).to be_false
			end
		end
	end

	context "instance methods" do
		describe "#humanize_showing_at" do 
			it "must return a human readable time string" do
				showtime = FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now)
				expect(showtime.humanize_showing_at).to be_kind_of(String)
			end
		end

		describe "#name" do 
			it "must return the movie name, cinema name and showing_at in a string" do
				showtime = FactoryGirl.create(:showtime, movie:movie, cinema:cinema, showing_at: Time.now)
				expect(showtime.name).to include(movie.name)
				expect(showtime.name).to include(cinema.name)
				expect(showtime.name).to include(showtime.humanize_showing_at)
			end
		end
	end

end