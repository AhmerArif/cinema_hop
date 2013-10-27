require 'spec_helper'

feature 'View showtimes for a movie' do
  let!(:city_all) { FactoryGirl.create(:city, name: 'All') }
  let!(:city_A) { FactoryGirl.create(:city) }
  let!(:city_B) { FactoryGirl.create(:city) }
  let!(:cinema_A) { FactoryGirl.create(:cinema, city:city_A) }
  let!(:cinema_B) { FactoryGirl.create(:cinema, city:city_B) }
  let!(:movie_A) { FactoryGirl.create(:movie) }
  let!(:movie_B) { FactoryGirl.create(:movie) }

  scenario 'Movie has current showtimes' do
    showtime_A = FactoryGirl.create(:showtime, movie:movie_A, cinema:cinema_A)
    showtime_B =FactoryGirl.create(:showtime, movie:movie_B, cinema:cinema_B)
    visit root_path
    first(:link, movie_A.name.titleize).click
    expect(page).to have_content(movie_A.name.titleize)
    expect(page).to have_content(cinema_A.name.titleize)
    #expect(page).to have_content(showtime_A.showing_at)
  end

  scenario 'Movie has current showtimes' do
    click_link(movie_A.name)
    expect(page).to have_content("This movie isn't being shown in any cinemas around at the moment")
    #expect(page).to have_content(showtime_A.showing_at)
  end

end