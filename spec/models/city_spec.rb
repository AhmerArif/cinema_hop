require 'spec_helper'

describe City do
	let(:city) { FactoryGirl.create(:city) }
 	let(:cinema) { FactoryGirl.create(:cinema) }

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

end
