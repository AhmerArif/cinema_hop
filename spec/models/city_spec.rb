require 'spec_helper'

describe City do

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

	context "methods" do

		let(:city_A) { FactoryGirl.create(:city) }
		let(:city_B) { FactoryGirl.create(:city) }
		let(:city_C) { FactoryGirl.create(:city, name:"All") }
	 	let(:cinema_A) { FactoryGirl.create(:cinema, city:city_A) }
	 	let(:cinema_B) { FactoryGirl.create(:cinema, city:city_A) }
	 	let(:cinema_C) { FactoryGirl.create(:cinema, city:city_B) }
	 	let(:movie_A) { FactoryGirl.create(:movie) }
	 	let(:movie_B) { FactoryGirl.create(:movie) }
	 	let(:movie_C) { FactoryGirl.create(:movie) }

		describe "#current_movies" do
			it "returns currently showing movies in the city" do
				FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
				FactoryGirl.create(:showtime, movie:movie_B, cinema:cinema_B)
				expect(city_A.current_movies).to include movie_A
				expect(city_A.current_movies).to include movie_B
			end	

			it "does not return currently showing movies in other cities" do
				FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_C)
				expect(city_A.current_movies).not_to include movie_A
			end	

			it "returns all currently showing movies in the country for the default city" do
				FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
				FactoryGirl.create(:showtime, movie:movie_B, cinema:cinema_C)
				expect(city_C.current_movies).to include movie_A
			end

		end

	end
end