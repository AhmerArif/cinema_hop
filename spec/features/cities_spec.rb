require 'spec_helper'

feature 'We should be able to select our city' do
  let(:city_all) { FactoryGirl.create(:city, name: 'All') }
  let(:city_A) { FactoryGirl.create(:city) }
  let(:city_B) { FactoryGirl.create(:city) }
  
  # http://stackoverflow.com/questions/14871918/undefined-local-variable-or-method-root-path-rspec-spork-guard
  scenario "when we visit the root page" do
    before  { 
      visit root_path 
      page.body.should have_link(city_A.name, :href=>cities_path(city_A))
      page.body.should have_link(city_B.name, :href=>cities_path(city_B))
      page.body.should have_link(city_all.name, :href=>cities_path(city_all))
    }
  end
end

feature 'View currently showing movies' do
  let(:city_all) { FactoryGirl.create(:city, name: 'All') }
  let(:city_A) { FactoryGirl.create(:city) }
  let(:city_B) { FactoryGirl.create(:city) }
  let(:cinema_A) { FactoryGirl.create(:cinema, city_id:city_A) }
  let(:cinema_B) { FactoryGirl.create(:cinema, city_id:city_B) }
  let(:movie_A) { FactoryGirl.attributes_for(:movie) }
  let(:movie_B) { FactoryGirl.attributes_for(:movie) }

  context "for all cities" do

    scenario 'Movies currently showing somewhere in the country' do
      FactoryGirl.create(:showtime, movie_id:movie_A, cinema_id:cinema_A)
      FactoryGirl.create(:showtime, movie_id:movie_B, cinema_id:cinema_B)
      click_link(city_all.name)
      page.should have_content(movie_A.name)
      page.should have_content(movie_B.name)
    end

    scenario 'Movie not being shown anywhere in the country over the next 2 days' do
      FactoryGirl.create(:showtime, movie_id:movie_A, cinema_id:cinema_A, showing_at:Timezone.now+49.hours)
      click_link(city_all.name)
      page.should_not have_content(movie_A.name)
    end

    scenario 'Movie stopped being shown in the country' do
      FactoryGirl.create(:showtime, movie_id:movie_A, cinema_id:cinema_A, showing_at:Timezone.now-1.hours)
      click_link(city_all.name)
      page.should_not have_content(movie_A.name)
    end

    scenario 'Movies do not have a registered showtime' do
      click_link(city_all.name)
      page.should_not have_content(movie_A.name)
      page.should_not have_content(movie_B.name)
    end

  end
 
  context "for a particular city" do

    scenario 'Movie in the city vs movie not in city' do
      FactoryGirl.create(:showtime, movie_id:movie_A, cinema_id:cinema_A)
      FactoryGirl.create(:showtime, movie_id:movie_B, cinema_id:cinema_B)
      click_link(city_A.name)
      page.should have_content(movie_A.name)
      page.should_not have_content(movie_B.name)
    end

  end

end