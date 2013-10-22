require 'spec_helper'

describe Movie do

	context "attributes" do
		it { should have_db_column(:name).of_type(:string) }
		it { should have_db_column(:slug).of_type(:string) }
		it { should have_db_column(:imdb_link).of_type(:string) }
		it { should have_db_column(:rotten_tomatoes_link).of_type(:string) }
	end

	context "associations" do
		it { should have_many(:cinemas)}
		it { should have_many(:showtimes)}
	end

	context "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
	end

end
