require 'spec_helper'

describe City do
	let(:city) { FactoryGirl.create(:city) }
 	let(:cinema) { FactoryGirl.create(:cinema, city_id:city) }
 	let(:movie) { FactoryGirl.create(:movie) }

	context "attributes" do
		it { should have_db_column(:name).of_type(:string) }
		it { should have_db_column(:slug).of_type(:string) }
	end

	context "associations" do
		it { should have_many(:cinemas)}
	end

	context "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
	end

	describe "#current_movies" do
		it "should return currently showing movies in the city" do
			FactoryGirl.create(:showtime, movie_id:movie, cinema_id:cinema)
			expect(city.current_movies).to include movie
		end

	end

end
