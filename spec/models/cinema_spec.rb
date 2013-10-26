require 'spec_helper'

describe Cinema do
	context "attributes" do
		it { should have_db_column(:name).of_type(:string) }
		it { should have_db_column(:website).of_type(:string) }
		it { should have_db_column(:address).of_type(:text) }
	end

	context "associations" do
		it { should belong_to(:city)}
		it { should have_many(:showtimes)}
		it { should have_many(:movies).through(:showtimes)}
	end

	context "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:city) }
		it { should validate_uniqueness_of(:name) }
		it { should validate_presence_of(:website) }
	end

end