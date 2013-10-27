require 'spec_helper'

feature 'We should be able to select our city' do
  
  # http://stackoverflow.com/questions/14871918/undefined-local-variable-or-method-root-path-rspec-spork-guard
  scenario "when we visit the root page" do
      city_all = FactoryGirl.create(:city, name: 'All')
      city_A = FactoryGirl.create(:city)
      visit root_path 
      expect(page.body).to have_link(city_A.name, :href=>city_path(city_A))
      expect(page.body).to have_link(city_all.name, :href=>city_path(city_all))
  end
end

feature 'View currently showing movies' do
  let!(:city_all) { FactoryGirl.create(:city, name: 'All') }
  let!(:city_A) { FactoryGirl.create(:city) }
  let!(:city_B) { FactoryGirl.create(:city) }
  let!(:cinema_A) { FactoryGirl.create(:cinema, city:city_A) }
  let!(:cinema_B) { FactoryGirl.create(:cinema, city:city_B) }
  let!(:movie_A) { FactoryGirl.create(:movie) }
  let!(:movie_B) { FactoryGirl.create(:movie) }

  before do 
    visit root_path
  end

  context "for all cities" do

    scenario 'Movies currently showing somewhere in the country' do
      FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
      FactoryGirl.create(:showtime, movie:movie_B, cinema:cinema_B)
      click_link(city_all.name)
      expect(page).to have_content(movie_A.name.titleize)
      expect(page).to have_content(movie_B.name)
    end

=begin Feature under consideration

    scenario 'Movie not being shown anywhere in the country over the next 2 days' do
      FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A, showing_at:Time.now+49.hours)
      click_link(city_all.name)
      expect(page).not_to have_content(movie_A.name)
    end

=end

    scenario 'Movie stopped being shown in the country' do
      FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A, showing_at:Time.now)
      Timecop.freeze(3.days.from_now) do
        click_link(city_all.name)
        expect(page).not_to have_content(movie_A.name)
      end
    end

    scenario 'Movies do not have a registered showtime' do
      click_link(city_all.name)
      expect(page).not_to have_content(movie_A.name)
      expect(page).not_to have_content(movie_B.name)
    end

  end
 
  context "for a particular city" do

    scenario 'Movie in the city vs movie not in city' do
      FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
      FactoryGirl.create(:showtime, movie:movie_B, cinema:cinema_B)
      click_link(city_A.name)
      expect(page).to have_content(movie_A.name.titleize)
      expect(page).not_to have_content(movie_B.name)
    end

  end

end